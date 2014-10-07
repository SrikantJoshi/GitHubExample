// NOTE: this trigger was created for prototype purposes only.  It needs much more testing and
// needs to be integrated into the overall trigger architecture, where we have one trigger
// per object.  Also, the Approver update needs SOQL removed from a FOR loop (per SFDC best
// practices) and it needs to handle cases where an Account exists in multiple territories.
// 
// It does the following:
// 	- If Opportunity Approval Status was changed to "Submitted," it looks up the proper Approver
// 	  and updates it on the Opportunity
// 	- If Opportunity Approval Status was changed to "Approved," it updates any product line items
// 	  that are not Lost/Cancelled/Hold to Won
// 	  
trigger Core_Opp_Approval on Opportunity (after update) {
    
    // Get all of the IDs for the Opportunities being updated, for subsequent SOQL
    Set<Id> oppIds = new Set<Id>();
    for (Opportunity opp : Trigger.new)
        oppIds.add(opp.Id);
    
    // Get all of the Opportunity Products that we *might* update, where Status is not Lost/Cancelled/Hold.
    // NOTE: this could probably be refactored so that it only happens for Opportunities whose Approval
    // Status was changed to Approved.
    List<OpportunityLineItem> oppProdList =
        [Select Id, OpportunityId, Core_Status__c from OpportunityLineItem
         where OpportunityId in :oppIds and Core_Status__c not in ('Lost', 'Cancelled', 'Hold')];
    
    // This will hold our final list of the actual Opp Prod IDs we're updating
    Set<Id> oppProdIdsWon = new Set<Id>();
    
    // This will hold our final list of Opportunity IDs where we need to find an Approver
    List<Id> oppIdsToGetApprover = new List<Id>();
    
    // Iterate through the Opportunities being updated, to see which ones we need to act on
    for (Opportunity opp : Trigger.new) {
    
        String oldStatus = Trigger.oldMap.get(opp.Id).Core_Approval_Status__c;
        
        // Check to see if the Approval Status changed, and if the new value is "Submitted"
        if ((oldStatus != opp.Core_Approval_Status__c) && (opp.Core_Approval_Status__c == 'Submitted')) {
            
            // Add to the set of where we need to find the Approver
            oppIdsToGetApprover.add(opp.Id);
        }        
        
        // Check to see if the Approval Status changed, and if the new value is "Approved"
        if ((oldStatus != opp.Core_Approval_Status__c) && (opp.Core_Approval_Status__c == 'Approved')) {
            
            // Add to the set of Opportunity Products we need to update, if they are not Lost/Cancelled/Hold
            for (OpportunityLineItem oppProd : oppProdList)
                if (oppProd.OpportunityId == opp.Id)
                    oppProdIdsWon.add(oppProd.Id);
        }
    }
    
    // Opportunity Approver update, if necessary
    if ((oppIdsToGetApprover != null) && (oppIdsToGetApprover.size() > 0)) {
        
        for (Id oppId : oppIdsToGetApprover) {
            
            // Below section of code needs to be refactored to remove SOQL from FOR loop
            
            // First check to see if there's an Opportunity Approver on the Territory
            Opportunity opp = [select Id, AccountId, OwnerId, Owner.ManagerId, Core_Approver__c
                               from Opportunity where Id = :oppId limit 1];
            Id acctId = opp.AccountId;
            List<UserTerritory2Association> userTerrAssoc = [SELECT UserId, RoleInTerritory2 FROM UserTerritory2Association
                                                             where Territory2Id in (SELECT Territory2Id FROM ObjectTerritory2Association
                                                                                    where ObjectId = :acctId)
                                                             and RoleInTerritory2 = 'Opportunity Approver'
                                                             limit 1];
            
            if ((userTerrAssoc != null) && (userTerrAssoc.size() > 0)) {
                
                opp.Core_Approver__c = userTerrAssoc[0].UserId;
                
            } else {
                
                // If no approver at Territory level, get the opportunity owner's manager
                opp.Core_Approver__c = opp.Owner.ManagerId;
            }
            
            update opp;            
        }
    }
    
    // Opportunity Product update to "Won", if necessary
    if ((oppProdIdsWon != null) && (oppProdIdsWon.size() > 0)) {
        
        // Get the exact Opportunity Product records we need to update, and perform the update
        List<OpportunityLineItem> oppProdsWon =
            [select Id, Core_Status__c from OpportunityLineItem where Id in :oppProdIdsWon];
        
        for (OpportunityLineItem oppLI : oppProdsWon)
            oppLI.Core_Status__c = 'Won';
        
        update oppProdsWon;
    }
}
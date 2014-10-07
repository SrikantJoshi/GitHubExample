/**************************************************************************************
Apex Class Name:  Core_Change_Request_Handler
Version     : 1.0 
Created Date: 30 SEP 2014
Function    : Handler Class for trigger on Change Request object
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             30/09/2014              Original Version
*************************************************************************************/
public class Core_Change_Request_Handler
{
    /*
    * Method name  : ChangeRequestBeforeHandler
    * Description  : Method to update the owner of Change Request record to the related account owner on creation/updation. 
    * Return Type  : VOID
    * Parameter    : List Trigger.new, MAP Trigger.newmap
    */
    
    public static void ChangeRequestBeforeHandler(List<Change_Requests__c> changeRequestList,Map<Id,Change_Requests__c> changeRequestMap)
    {
        Map<Id,Account> accountMap;
        Set<Id> accountIds = new Set<Id>();
        
        for(Change_Requests__c changeRequestInstance : changeRequestList)
        {
            accountIds.add(changeRequestInstance.Account__c);
        }
        
        accountMap = new Map<Id,Account>([SELECT Id,OwnerId FROM Account Where Id In :accountIds]);
        
        for(Change_Requests__c changeRequestInstance : changeRequestList)
        {
            changeRequestInstance.OwnerId = accountMap.get(changeRequestInstance.Account__c).OwnerId;
        }
    }
}
public with sharing class Core_CCV_Controller {

    public CCV__c ccvRec { get; set; }
    public List<Value_Chain__c> ccvDetail { get; set; }

    public Core_CCV_Controller() {
    
        String paramId = apexpages.currentpage().getparameters().get('id');
           
        ccvRec = [SELECT Id, Name, Account__c, Opportunity__c 
                  FROM CCV__c 
                  WHERE Id = :paramId];

        ccvDetail = [SELECT Id, Function__c, KPI__c, Challenges__c, Goals__c, Proposals__c
                     FROM Value_Chain__c 
                     WHERE CCV__c = :paramId
                     ORDER BY Function__c];

        while (ccvDetail.size() <= 4)
        {
            ccvDetail.add(ccvDetail[0]);
        }
    }

}
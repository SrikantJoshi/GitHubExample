public class Core_CCV_CloneController {

    //added an instance varaible for the standard controller
    private ApexPages.StandardController controller {get; set;}
    
     // add the instance for the variables being passed by id on the url
    private CCV__c ccv {get;set;}
    
    // set the id of the record that is created -- ONLY USED BY THE TEST CLASS
    public ID newRecordId {get;set;}

    // initialize the controller
    public Core_CCV_CloneController(ApexPages.StandardController controller) {

        //initialize the stanrdard controller
        this.controller = controller;
        
        // load the current record
        ccv = (CCV__c)controller.getRecord();

    }

    // method called from the VF's action attribute to clone the CCV
    public PageReference cloneWithItems() {

         // setup the save point for rollback
         Savepoint sp = Database.setSavepoint();
         CCV__c newCCV;

         try {

             ccv = [select Id, Name, Account__c, Opportunity__c from CCV__c where id = :ccv.id];
             newCCV = ccv.clone(false);
             insert newCCV;

             // set the id of the new po created for testing
             newRecordId = newCCV.id;

             List<Value_Chain__c> itemsVC = new List<Value_Chain__c>();
             for (Value_Chain__c vc : [SELECT Id, Name, CCV__c, Challenges__c, Function__c, Proposals__c, KPI__c, Goals__c FROM Value_Chain__c WHERE CCV__c = :ccv.id]) {
                  Value_Chain__c newVC = vc.clone(false);
                  newVC.CCV__c = newCCV.id;
                  itemsVC.add(newVC);
             }
             insert itemsVC;

             List<Capability_Matrix__c> itemsCM = new List<Capability_Matrix__c>();
             for (Capability_Matrix__c cm : [SELECT Id, Name, CCV__c, Company__c, Other__c, People__c, Products_Services__c, Programs__c FROM Capability_Matrix__c WHERE CCV__c = :ccv.id]) {
                  Capability_Matrix__c newCM = cm.clone(false);
                  newCM.CCV__c = newCCV.id;
                  itemsCM.add(newCM);
             }
             insert itemsCM;             
             
         } catch (Exception e){
             // roll everything back in case of error
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
         }

        return new PageReference('/'+newCCV.id+'/e?retURL=%2F'+newCCV.id);
    }

}
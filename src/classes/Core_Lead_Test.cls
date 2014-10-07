/**************************************************************************************
Apex Class Name:  Core_Lead_Test
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Test Class for the Core_Lead trigger
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/06/2014              Original Version
*************************************************************************************/
@isTest
public class Core_Lead_Test{
     
    /*
    * Method name  : Core_Lead_Test
    * Description  : test method to cover Core_Lead trigger
    * Return Type  : VOID
    * Parameter    : NONE
    */ 
    static testMethod void Core_Lead_Test(){
        
        //Declare/Initialize the Variables
        List<Lead> lstLead = new List<Lead>();
        List<Core_Country_State_Reference__c> lstCS = new List<Core_Country_State_Reference__c>{};
        
        // Construct the CountryStateReference instances
        lstCS = Core_Test_Handler.Core_CountryState(200);
        
        for(Core_Country_State_Reference__c sobjCS : lstCS){
            sobjCS.Core_Country__c = 'INDIA';
            sobjCS.Core_Geo__c  = 'Asia';
            sobjCS.Core_State__c = 'Karnataka';
            sobjCS.Core_Sub_Geo__c = 'South Asia';
        }
        
        // Insert the intialized Leads
        Database.SaveResult[] lstSaveResultCS = Database.insert(lstCS, false);

        // Construct the Lead instances        
        lstLead = Core_Test_Handler.Core_Lead(200);
           
        for(Lead sobjAcc : lstLead){
            sobjAcc.State = 'Karnatak';
            sobjAcc.Country = 'INDIA';
        }
        
        // Insert the intialized Leads
        Database.SaveResult[] lstSaveResultLead = Database.insert(lstLead, false);
        
        // Change the values in the Lead record for updation 
        for(Lead sobjAcc : lstLead){
            sobjAcc.State = 'Karnataka';
            sobjAcc.Country = 'INDIA';    
        }
        
        //Insert the updated Leads
        lstSaveResultLead  = Database.update(lstLead, false);
        
        
        // Query the database for the newly inserted records.
        List<Lead> lstInsertedLeads = [SELECT Name,Core_Lead_Geo__c, Core_Lead_Sub_Geo__c
                                          FROM Lead 
                                          WHERE Id IN :lstLead];                                         
            
        // Assert that the Lead geo/Sub geo field contains the proper value now.
        for(Lead sobjAccnt : lstInsertedLeads){
          System.assertEquals( 'Asia',  sobjAccnt.Core_Lead_Geo__c);
          System.assertEquals( 'South Asia',  sobjAccnt.Core_Lead_Sub_Geo__c);
        }
    }
}
/**************************************************************************************
Apex Class Name:  Core_Account_Test
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Test Class for the Core_Account trigger
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/06/2014              Original Version
*************************************************************************************/
@isTest
public class Core_Account_Test{
     
    /*
    * Method name  : Core_Account_Test
    * Description  : test method to cover Core_Account trigger
    * Return Type  : VOID
    * Parameter    : NONE
    */ 
    static testMethod void Core_Account_Test(){
        
        //Declare/Initialize the Variables
        List<Account> lstAccount = new List<Account>();
        List<Core_Country_State_Reference__c> lstCS = new List<Core_Country_State_Reference__c>{};
        
        lstCS = Core_Test_Handler.Core_CountryState(200);
        
        // Construct the CountryStateReference instances
        for(Core_Country_State_Reference__c sobjCS : lstCS){
            sobjCS.Core_Country__c = 'INDIA';
            sobjCS.Core_Geo__c  = 'Asia';
            sobjCS.Core_State__c = 'Karnataka';
            sobjCS.Core_Sub_Geo__c = 'South Asia';
        }
        
        // Insert the intialized accounts
        Database.SaveResult[] lstSaveResultCS = Database.insert(lstCS, false);
        
        lstAccount = Core_Test_Handler.Core_Account(200);
           
        // Construct the Account instances
        for(Account sobjAcc : lstAccount){
            sobjAcc.billingState = 'Karnatak';
            sobjAcc.billingCountry = 'INDIA';
        }
        
        // Insert the intialized accounts
        Database.SaveResult[] lstSaveResultAccount = Database.insert(lstAccount, false);
        
        // Change the values in the Account record for updation 
        for(Account sobjAcc : lstAccount){
            sobjAcc.billingState = 'Karnataka';
            sobjAcc.billingCountry = 'INDIA';    
        }
        
        //Insert the updated accounts
        lstSaveResultAccount  = Database.update(lstAccount, false);
        
        
        // Query the database for the newly inserted records.
        List<Account> lstInsertedAccounts = [SELECT Name,Account_Geo__c, Account_Sub_Geo__c
                                          FROM Account 
                                          WHERE Id IN :lstAccount];                                         
            
        // Assert that the Account geo/Sub geo field contains the proper value now.
        for(Account sobjAccnt : lstInsertedAccounts){
          System.assertEquals( 'Asia',  sobjAccnt.Account_Geo__c);
          System.assertEquals( 'South Asia',  sobjAccnt.Account_Sub_Geo__c);
        }
    }
}
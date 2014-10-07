/****************************************************************************************************
Apex Class Name:  Core_Change_Request_Handler_Test
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Test class for "Core_ChangeRequest" Trigger and "Core_Change_Request_Handler" Class
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             06/10/2014              Original Version
*****************************************************************************************************/

@isTest 
private class Core_Change_Request_Handler_Test
{
    Static List<Account> accountList;
    
    Static List<Change_Requests__c> changeRequestList;
    
    Static user systemAdminUser;
    
    
    /*
    * Method name  : setupTestData
    * Description  : Method to setup test data ( Accounts )
    * Return Type  : None
    * Parameter    : None
    */
    
    static void setupTestData()
    {
        List<User> usersList = new List<User>();
        usersList = [SELECT Id,Name FROM User where isActive = TRUE AND Profile.Name = 'System Administrator'];
        
        for(User sysAdminUser : usersList)
        {
            if(sysAdminUser.Id != UserInfo.getUserId())
                systemAdminUser = sysAdminUser;
        }
        
        accountList = new List<Account>();
        accountList = Core_Utility_data_create.createAccount(20);
        insert accountList;

    }
    
    /*
    * Method name  : setupChangeRequest
    * Description  : Method to setup test data ( Change Request)
    * Return Type  : None
    * Parameter    : None
    */
    
    static void setupChangeRequest()
    {
       changeRequestList = new List<Change_Requests__c >();
       changeRequestList = Core_Utility_data_create.createChangeRequest(accountList);
       insert changeRequestList;

    }
    
    
    /*
    * Method name  : changeRequestCreate
    * Description  : Testmethod method for testing "Core_ChangeRequest" Trigger and "Core_Change_Request_Handler" Class
    * Return Type  : None
    * Parameter    : None
    */
   
    static testMethod void changeRequestCreate() 
    {
        setupTestData();
        
        Test.startTest();
        
        System.runAs(systemAdminUser)
        {
            setupChangeRequest();
        }
        
        for(Change_Requests__c changeRequestInstance : changeRequestList)
            System.assertEquals(changeRequestInstance.OwnerId, changeRequestInstance.Account__r.OwnerId);
            
        Test.stopTest();
        
        
    }
    
}
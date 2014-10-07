/****************************************************************************************************
Apex Class Name:  Core_Utility_data_create
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Utility Class for creating data ( used in test classes )
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             06/10/2014              Original Version
*****************************************************************************************************/

public class Core_Utility_data_create
{

    /*
    * Method name  : createAccount
    * Description  : Method to create and return an account instance.
    * Return Type  : Account
    * Parameter    : None
    */
    
    public static List<Account> createAccount(Integer size)
    {
        List<Account> accountList = new List<Account>();
        For(integer i = 0; i < size; i++)
        {
            Account accountInstance = new Account();
            accountInstance.name = 'Test ' + i;
            accountList.add(accountInstance);
        }
        return accountList;
    }
    
    
    /*
    * Method name  : createChangeRequest
    * Description  : Method to create and return an Change Request instance.
    * Return Type  : List of Change Request records
    * Parameter    : List of Account records
    */
    
    public static List<Change_Requests__c> createChangeRequest(List<Account> accountList)
    {
        List<Change_Requests__c> changeRequestList = new List<Change_Requests__c>();
        
        For(integer i = 0; i < accountList.size(); i++)
        {
             Change_Requests__c changeRequestInstance = new Change_Requests__c();
             changeRequestInstance.Account__c = accountList.get(i).Id;
             changeRequestList.add(changeRequestInstance);
        }
        return changeRequestList;
    }
    
    
    /*
    * Method name  : createAccount
    * Description  : Method to create and return an account instance.
    * Return Type  : Account
    * Parameter    : None
    */
    
    public static List<Lead> createLead(Integer size)
    {
        List<Lead> leadList = new List<Lead>();
        for(integer i = 0; i < size; i++)
        {
            Lead leadInstance = new Lead();
            leadInstance.FirstName = 'Test ';
            leadInstance.lastName = String.valueOf(i);
            leadInstance.Company = 'Test';
            leadInstance.Core_Last_Activity_Date__c = System.Now().addHours(-2);
            leadList.add(leadInstance);
        }
        return leadList;
    }
    
    
   /*
    * Method name  : createTask
    * Description  : Method to create and return a task instance.
    * Return Type  : Account
    * Parameter    : None
    */
    
    public static List<Task> createTask(Integer size)
    {
        List<Task> taskList = new List<Task>();
        for(integer i = 0; i < size; i++)
        {
            Task taskInstance = new Task();
            taskInstance.ActivityDate = System.Today().addDays(1);
            taskInstance.Priority = 'High';
            taskInstance.Status = 'In Progress';
            taskInstance.Subject= 'Call';
            taskList.add(taskInstance);
            
        }
        return taskList;
    }
    
    
    /*
    * Method name  : createEvent
    * Description  : Method to create and return an event instance.
    * Return Type  : Account
    * Parameter    : None
    */
    
    public static List<Event> createEvent(Integer size)
    {
        List<Event> eventList = new List<Event>();
        for(integer i = 0; i < size; i++)
        {
            Event eventInstance = new Event();
            eventInstance.ActivityDateTime = System.Now().addHours(1);
            eventInstance.Subject= 'Call';
            eventInstance.DurationInMinutes = 3000;
            eventList.add(eventInstance);   
            
        }
        return eventList;
    }
    
}
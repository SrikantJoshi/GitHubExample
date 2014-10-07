/****************************************************************************************************
Apex Class Name:  Core_Change_Request_Handler_Test
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Test class for "Core_Task" trigger, "Core_Event" trigger and "Core_Activity_Handler" Class
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             06/10/2014              Original Version
*****************************************************************************************************/

@isTest 
private class Core_Activity_Handler_Test
{
    Static List<lead> leadInsertion;
    
    Static List<Task> taskInsertion;
    
    Static List<Event> eventInsertion;
    
    
    /*
    * Method name  : setupTestData
    * Description  : Method to setup test data ( Leads)
    * Return Type  : None
    * Parameter    : None
    */
    static void setupTestData()
    {
        leadInsertion = new List<Lead>();
        leadInsertion = Core_Utility_data_create.createLead(20);
        insert leadInsertion;    
        
    }
    
   /*
    * Method name  : createTasks
    * Description  : Method to insert Tasks
    * Return Type  : None
    * Parameter    : None
    */
    static void createTasks()
    {
        taskInsertion = new List<Task>();
       
        
        taskInsertion = Core_Utility_data_create.createTask(20);
        
        for(Integer i = 0; i < taskInsertion.size(); i++)
        {
            taskInsertion.get(i).whoId = leadInsertion.get(i).Id;
        }
        
        
        insert taskInsertion;    
        
    }
    
    
    /*
    * Method name  : createTasks
    * Description  : Method to insert Tasks
    * Return Type  : None
    * Parameter    : None
    */
    static void createEvents()
    {
        eventInsertion = new List<Event>();
        eventInsertion = Core_Utility_data_create.createEvent(20);

        for(Integer i = 0; i < leadInsertion.size(); i++)
        {
            eventInsertion.get(i).whoId = leadInsertion.get(i).Id;
        } 
        insert eventInsertion;    
        
    }
    
    /*
    * Method name  : changeRequestCreate
    * Description  : Testmethod method for testing "Core_Task" trigger, "Core_Event" trigger and "Core_Activity_Handler" Class
    * Return Type  : None
    * Parameter    : None
    */
   
    static testMethod void changeRequestCreate() 
    {
        setupTestData();
        
        Test.startTest();
        
        createTasks();
        
        createEvents();
            
        Test.stopTest();
        
        
    }
}
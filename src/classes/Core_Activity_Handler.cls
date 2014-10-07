/**************************************************************************************
Apex Class Name:  Core_Activity_Handler
Version     : 1.0 
Created Date: 30 SEP 2014
Function    : Handler Class for trigger on Activity ( Task & Event ) object
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             30/09/2014              Original Version
*************************************************************************************/
public class Core_Activity_Handler
{
    
    private static String leadPrefix = Lead.sObjectType.getDescribe().getKeyPrefix();
    private static List<Lead> leadUpdateList = new List<Lead>();
    private static Map<Id,Id> leadTaskMap = new Map<Id,Id>();
    private static Set<Id> leadIds = new Set<Id>();
    
    /*
    * Method name  : taskLastActivityDateUpdate
    * Description  : Method to update the Last Activity Date field on related lead record on creation/updation of task. 
    * Return Type  : VOID
    * Parameter    : List Trigger.new, MAP Trigger.newmap
    */
    public static void taskLastActivityDateUpdate(List<Task> tasksList,Map<Id,Task> taskMap)
    {
    
       
        
         for(Task taskInstance : tasksList)
         {
             if(String.valueOf(taskInstance.whoId)!= NULL && String.valueOf(taskInstance.whoId).startsWith(leadPrefix))
             {
                 leadIds.add(taskInstance.whoId);  
                 leadTaskMap.put(taskInstance.whoId,taskInstance.Id);
             }   
         }
         
         if(!leadIds.isEmpty())
         {
             leadUpdateList =[SELECT Id,Core_Last_Activity_Date__c From Lead Where Id IN :leadIds];
             
             for(Lead leadInstance : leadUpdateList)
             {
                 leadInstance.Core_Last_Activity_Date__c = taskMap.get(leadTaskMap.get(leadInstance.Id)).LastModifiedDate;
             }
             
             Database.SaveResult[] srList = Database.update(leadUpdateList, false);
             
             for (Database.SaveResult sr : srList) 
             {
                if (!sr.isSuccess()) 
                {
                    for(Database.Error err : sr.getErrors()) 
                    {
                        System.debug(System.Label.Exception);                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug(System.Label.Exception_Field_Message + err.getFields());
                    }
                }
                
             }
             
         }
    }
    
    
    /*
    * Method name  : eventLastActivityDateUpdate
    * Description  : Method to update the Last Activity Date field on related lead record on creation/updation of event. 
    * Return Type  : VOID
    * Parameter    : List Trigger.new, MAP Trigger.newmap
    */
    
    public static void eventLastActivityDateUpdate(List<Event> eventList,Map<Id,Event> eventMap)
    {
        for(Event eventInstance : eventList)
         {
            
             
             if(String.valueOf(eventInstance.whoId)!= NULL && String.valueOf(eventInstance.whoId).startsWith(leadPrefix))
             {
                 leadIds.add(eventInstance.whoId);  
                 leadTaskMap.put(eventInstance.whoId,eventInstance.Id);
             }   
         }
         
         if(!leadIds.isEmpty())
         {
             leadUpdateList =[SELECT Id,Core_Last_Activity_Date__c From Lead Where Id IN :leadIds];
             
             System.debug(leadUpdateList);
             System.debug(eventMap);
             System.debug(leadTaskMap);
             for(Lead leadInstance : leadUpdateList)
             {
                 leadInstance.Core_Last_Activity_Date__c = eventMap.get(leadTaskMap.get(leadInstance.Id)).LastModifiedDate;
             }
             
             Database.SaveResult[] srList = Database.update(leadUpdateList, false);
             
             for (Database.SaveResult sr : srList) 
             {
                if (!sr.isSuccess()) 
                {
                    for(Database.Error err : sr.getErrors()) 
                    {
                        System.debug(System.Label.Exception);                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug(System.Label.Exception_Field_Message + err.getFields());
                    }
                }
                
             }
         }
    }
    
    
   
}
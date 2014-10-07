/**************************************************************************************
Apex Class Name:  Core_Event
Version     : 1.0 
Created Date: 03 SEP 2014
Function    : Trigger for Event object
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             09/30/2014              Original Version
*************************************************************************************/
trigger Core_Event on Event (after insert, after update) 
{
     if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate))
        Core_Activity_Handler.eventLastActivityDateUpdate(trigger.new,trigger.newMap);
}
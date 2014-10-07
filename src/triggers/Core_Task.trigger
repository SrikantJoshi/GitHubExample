/**************************************************************************************
Apex Class Name:  Core_Task
Version     : 1.0 
Created Date: 03 SEP 2014
Function    : Trigger for Task object
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             09/30/2014              Original Version
*************************************************************************************/
trigger Core_Task on Task (after insert, after update) 
{
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate))
        Core_Activity_Handler.taskLastActivityDateUpdate(trigger.new,trigger.newMap);
}
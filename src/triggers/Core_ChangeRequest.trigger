/**************************************************************************************
Apex Class Name:  Core_ChangeRequest
Version     : 1.0 
Created Date: 03 SEP 2014
Function    : Trigger for Change Request object
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Harshith M L             09/30/2014              Original Version
*************************************************************************************/
trigger Core_ChangeRequest on Change_Requests__c (before insert,before update)
{
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    {
        Core_Change_Request_Handler.ChangeRequestBeforeHandler(trigger.new,trigger.newMap);
    }
}
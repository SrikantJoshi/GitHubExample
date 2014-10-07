/**************************************************************************************
Apex Class Name:  Core_lead
Version     : 1.0 
Created Date: 03 OCT 2014
Function    : Trigger for the object lead
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/03/2014              Original Version
*************************************************************************************/
trigger Core_lead on lead (before insert, before update) {
       
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //Call the method to populate both Geo & Sub Geo fields using the Country State Reference object
        Core_Utility.sObjectBeforeHandler(Trigger.new,Trigger.newmap,Trigger.oldmap,System.Label.Core_Lead_Geo,System.Label.Core_Lead_Sub_Geo,System.Label.Core_Lead_State,System.Label.Core_Lead_Country);
    }

}
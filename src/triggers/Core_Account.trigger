/**************************************************************************************
Apex Class Name:  Core_Account
Version     : 1.0 
Created Date: 03 OCT 2014
Function    : Trigger for the object Account
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/03/2014              Original Version
*************************************************************************************/
trigger Core_Account on Account (before insert, before update) {
       
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //Call the method to populate both Geo & Sub Geo fields using the Country State Reference object
        Core_Utility.sObjectBeforeHandler(Trigger.new,Trigger.newmap,Trigger.oldmap,System.Label.Core_Account_Geo,System.Label.Core_Account_Sub_Geo,System.Label.Core_BillingState,System.Label.Core_BillingCountry);
    }

}
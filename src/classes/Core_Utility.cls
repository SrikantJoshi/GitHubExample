/**************************************************************************************
Apex Class Name:  Core_Utility
Version     : 1.0 
Created Date: 03 OCT 2014
Function    : Utility methods to handle generic functions
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/03/2014              Original Version
*************************************************************************************/
public class Core_Utility{

    /*
    * Method name  : sObjectBeforeHandler
    * Description  : Matches the Billing state in the accounts and populates Geo/Sub Geo fields 
    * Return Type  : VOID
    * Parameter    : List Trigger.new, MAP Trigger.newmap,MAP Trigger.oldmap,Feo field of Sobject, Sub Geo field of Sobject, State field of sobject, Country field of Sobject
    */
    public static void sObjectBeforeHandler(List<sObject> listNewAcccount,Map<Id,sObject> mapNewsObject,Map<Id,sObject> mapOldsObject,String sFieldGeo,String sFieldSubGeo,String sState,String sCountry){
        
        //Declare/Initialize the Variables
        Map<String,Core_Country_State_Reference__c> mapStateToGeo = new Map<String,Core_Country_State_Reference__c>();
        
        try{
            for(Core_Country_State_Reference__c sobjStateRef : [select ID,Name,Core_Country__c,Core_Geo__c,Core_State__c,Core_Sub_Geo__c from Core_Country_State_Reference__c]){
                mapStateToGeo.put(sobjStateRef.Core_Country__c+sobjStateRef.Core_State__c,sobjStateRef);
            }
            
            for(sObject sobjGeneric : listNewAcccount){// iterate over the new set of records
                // Check if the operation is INSERT OR if the Country field is changed OR if the state is changed
                if(mapNewsObject == NULL || String.Valueof(sobjGeneric.get(sState)) != String.Valueof(mapOldsObject.get(String.Valueof(sobjGeneric.get(System.Label.Core_Id))).get(sState)) || String.Valueof(sobjGeneric.get(sCountry)) != String.Valueof(mapOldsObject.get(String.Valueof(sobjGeneric.get(System.Label.Core_Id))).get(sCountry))){
                    if(mapStateToGeo.containsKey(String.Valueof(sobjGeneric.get(sCountry))+String.Valueof(sobjGeneric.get(sState)))){
                        sobjGeneric.put(sFieldGeo,String.Valueof(mapStateToGeo.get(String.Valueof(sobjGeneric.get(sCountry))+String.Valueof(sobjGeneric.get(sState))).Core_Geo__c));
                        sobjGeneric.put(sFieldSubGeo,String.Valueof(mapStateToGeo.get(String.Valueof(sobjGeneric.get(sCountry))+String.Valueof(sobjGeneric.get(sState))).Core_Sub_Geo__c));  
                    }
                    else{
                        // Assign empty value if the combination is NOT present
                        sobjGeneric.put(sFieldGeo,NULL);
                        sobjGeneric.put(sFieldSubGeo,NULL);  
                    }
                }
            }
        }
        catch(DmlException e){
            System.debug(System.Label.Core_Exception+e.getMessage());
        }
    }
}
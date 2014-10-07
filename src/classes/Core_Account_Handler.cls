public class Core_Account_Handler{

    public static void AccountBeforeHandler(List<Account> listNewAcccount,Map<Id,Account> mapNewAccount,Map<Id,Account> mapOldAccount){
        
        Map<String,SMG_Country_State_Reference__c> cSCountryStateRef = SMG_Country_State_Reference__c.getall();
        for(Account sobjAccount : listNewAcccount){
            if(mapNewAccount == NULL || sobjAccount.BillingState != mapOldAccount.get(sobjAccount.Id).BillingState){
                if(cSCountryStateRef.containsKey(sobjAccount.BillingState)){
                    sobjAccount.Account_Geo__c= cSCountryStateRef.get(sobjAccount.BillingState).SMG_Geo__c;
                    sobjAccount.Account_Sub_Geo__c = cSCountryStateRef.get(sobjAccount.BillingState).SMG_Sub_Geo__c;  
                }
                else{
                    sobjAccount.Account_Geo__c= NULL;
                    sobjAccount.Account_Sub_Geo__c = NULL; 
                }
            }
        }
    }
}
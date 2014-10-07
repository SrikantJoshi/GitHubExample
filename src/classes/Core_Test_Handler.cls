/**************************************************************************************
Apex Class Name:  Core_Account_Test
Version     : 1.0 
Created Date: 06 OCT 2014
Function    : Test methods for creation of records
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* Srikant Joshi             10/06/2014              Original Version
*************************************************************************************/
public class Core_Test_Handler{

    /*
    * Method name  : Core_Account
    * Description  : method to return the instances of Account
    * Return Type  : List<Account>
    * Parameter    : Size of records
    */
    public static List<Account> Core_Account(Integer iNoOfRecords){
        List<Account> lstAccount = new List<Account>{}; 
        for(integer iRecNo = 0; iRecNo < iNoOfRecords; iRecNo++){
            Account sobjAcc = new Account();
            sobjAcc.name = 'Account' + iRecNo;
            lstAccount.add(sobjAcc);
        }
        return lstAccount;
    }
    
    /*
    * Method name  : Core_Lead
    * Description  : method to return the instances of Lead
    * Return Type  : List<Lead>
    * Parameter    : Size of records
    */
    public static List<Lead> Core_Lead(Integer iNoOfRecords){
        List<Lead> lstLead = new List<Lead>{}; 
        for(integer iRecNo = 0; iRecNo < iNoOfRecords; iRecNo++){
            Lead sobjAcc = new Lead();
            sobjAcc.Company = 'Lead';
            sobjAcc.LastName = 'Lead';
            lstLead.add(sobjAcc);
        }
        return lstLead;
    }

    
    /*
    * Method name  : Core_CountryStateReference
    * Description  : method to return the instances of Core_Country_State_Reference__c
    * Return Type  : List<Core_Country_State_Reference__c>
    * Parameter    : Size of records
    */
    public static List<Core_Country_State_Reference__c> Core_CountryState(Integer iNoOfRecords){
        List<Core_Country_State_Reference__c> lstCS = new List<Core_Country_State_Reference__c>{}; 
        for(integer iRecNo = 0; iRecNo < iNoOfRecords; iRecNo++){
            Core_Country_State_Reference__c sobjCS = new Core_Country_State_Reference__c();
            lstCS.add(sobjCS);
        }
        return lstCS ;
    }

}
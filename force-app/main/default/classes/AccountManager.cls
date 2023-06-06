/************************************************************************************************
* Name      : AccountManager
* Purpose   : Class to test REST API
* Author    : Bruna Girão
* Date      : 06-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
05-06-2023          Bruna Girão             create class 
***************************************************************************************************/

@RestResource(urlMapping='/v1/AccountManager/*')
global with sharing class AccountManager {
    
    @HttpGet
    global static AccountInfoResponse accountInformation() {
        RestRequest request         = RestContext.request;
        String accountId            = request.requestURI.substringAfterLast('/');
        AccountInfoWrapper wrapper  = new AccountInfoWrapper(); 

        try {
            wrapper.AccountRecord = [
            SELECT Id, Name, Rating, Industry, 
                   Description, Phone, Fax
              FROM Account 
             WHERE Id =: accountId
             LIMIT 1
            ];

            if(wrapper.AccountRecord != null) {
                wrapper.Contacts = [
                    SELECT Id, Name, FirstName, 
                           LastName, Email, Phone
                      FROM Contact
                     WHERE AccountId =: accountId
                ];

                wrapper.Cases = [
                    SELECT Id, CaseNumber, Subject,
                           Description, Status, Owner.Name
                      FROM Case
                     WHERE AccountId =: accountId
                ];
            }

            return new AccountInfoResponse(
                false, 'Retrieve Account info successfuly', wrapper
            );

        } catch (Exception e) {
            return new AccountInfoResponse(e);
        }
    }


    @HttpPost
    global static AccountInfoResponse postAccountInfo(AccountInfoWrapper accountInfo){
        
        try {
            Account acc = accountInfo.AccountRecord;
            insert acc;

            return new AccountInfoResponse(
                false, 'Account Create successfully', new AccountInfoWrapper(acc, new List<Contact>(), new List<Case>())
            );

        } catch (Exception e) {
            return new AccountInfoResponse(e);
        }
    }

    


    global class AccountInfoResponse {

        global Boolean HasError                 {get; set;}
        global String Message                   {get; set;}
        global AccountInfoWrapper AccountInfo   {get; set;}
        
        global AccountInfoResponse() {}

        global AccountInfoResponse(Exception e) {
            this.HasError       = true;
            this.Message        = e.getMessage();
            this.AccountInfo    = new AccountInfoWrapper();
        }

        global AccountInfoResponse(Boolean hasError, String message, AccountInfoWrapper accountInfo) {
            this.HasError       = hasError;
            this.Message        = message;
            this.AccountInfo    = AccountInfo;
        }
        
    }

    global class AccountInfoWrapper {
        global Account AccountRecord        {get; set;}
        
        global List<Contact> Contacts       {get; set;}
        global List<Case> Cases             {get; set;}
        

        global AccountInfoWrapper() {}

        global AccountInfoWrapper(Account accountRecord, List<Contact> contacts, List<Case> cases) {
            this.AccountRecord      = accountRecord;
            this.Cases              = cases;
            this.Contacts           = contacts;
        }
    }

    global class AccountManagerException extends Exception{}
}
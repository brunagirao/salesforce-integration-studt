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
    global static AccountInfoResponse getAccountInfo() {
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
            Account accountRecord = accountInfo.AccountRecord;
            insert accountRecord;
            
            List<Contact> contacts;
            List<Case> cases;

            if(accountRecord != null) {
                contacts = accountInfo.Contacts;
                for(Contact ctt : contacts) {
                    ctt.AccountId = accountRecord.Id;
                }

                cases = accountInfo.Cases;
                for(Case cs : cases) {
                    cs.AccountId = accountRecord.Id;
                }
            }
            

            if(contacts != null && contacts.size() > 0) {
                insert contacts;
            } 

            if(cases != null && cases.size() > 0) {
                insert cases;
            }
            
            return new AccountInfoResponse(
                false, 'Account Create successfully', new AccountInfoWrapper(accountRecord, contacts, cases)
            );

        } catch (Exception e) {
            return new AccountInfoResponse(e);
        }
    }

    @HttpDelete
    global static AccountInfoResponse deleteAccountInfo(){
        RestRequest request = RestContext.request;
        String accountId    = request.requestURI.substringAfterLast('/');

        try {
            Account accountRecord = [
                SELECT Id,
                       (SELECT Id FROM Cases)
                  FROM Account 
                 WHERE Id =: accountId LIMIT 1
            ];

            if(!accountRecord.Cases.isEmpty()) {
                delete accountRecord.Cases;
            }

            delete accountRecord;

            return new AccountInfoResponse(
                false, 'Account record deleted successfully!', new AccountInfoWrapper()
            );

        } catch (Exception e) {
            return new AccountInfoResponse(e);
        }
    }

    @HttpPatch
    global static AccountInfoResponse updateAccountInfo(AccountInfoWrapper accountInfo) {
        RestRequest request = RestContext.request;
        String accountId    = request.requestURI.substringAfterLast('/');

        try {
            Account accountToUpdate;

            Account accountRecord = [
                SELECT Id FROM Account WHERE Id =: accountId LIMIT 1
            ];

            if(accountRecord != null) {
                accountToUpdate = new Account (
                    Id              = accountRecord.Id,
                    Rating          = accountInfo.AccountRecord.Rating,
                    AccountNumber   = accountInfo.AccountRecord.AccountNumber,
                    Description     = accountInfo.AccountRecord.Description
                );
            }

            update accountToUpdate;

            return new AccountInfoResponse(false, 'Account record update successfully', new AccountInfoWrapper(accountToUpdate, null, null));

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
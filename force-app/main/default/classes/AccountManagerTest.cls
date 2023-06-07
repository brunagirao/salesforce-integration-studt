/************************************************************************************************
* Name      : AccountManagerTest
* Purpose   : Class to test AccountManager class
* Author    : Bruna Girão
* Date      : 06-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
05-06-2023          Bruna Girão             create class 
***************************************************************************************************/

@isTest
public with sharing class AccountManagerTest {
    
    public static final String BASE_URL = '/service/apexrest/v1/AccountManager/';


    @TestSetup
    static void makeData(){
        
        //Account
        Account accountRecord = new Account(
            Name              = 'Account Test REST API',
            Rating            = 'Hot',
            Industry          = 'Education',
            Description       = 'Account Description Test',
            Phone             = '998855885566',
            Fax               = '998855885566'
        );
        insert accountRecord;
        
        //Contact
        Contact contactRecord = new Contact (
            FirstName       = 'Test',
            LastName        = 'Test LastName',
            Email           = 'test@email.com',
            Phone           = '998855885566',
            AccountId       = accountRecord.Id
        );
        insert contactRecord;

        //Case
        Case caseRecord = new Case (
            Subject     = 'Test REST API',
            Description = 'Test REST API Description',
            Status      = 'Open',
            AccountId   = accountRecord.Id
        );
        insert caseRecord;
    }

    @isTest
    public static void getAccountInfo_AccountFound_Test() {
        //Given
        String accountId = [SELECT Id FROM Account LIMIT 1].Id;
        createBaseRequest(accountId, 'GET');
        AccountManager.AccountInfoResponse response;

        //When
        try {
            Test.startTest();
                response = AccountManager.getAccountInfo();
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        //Then
        Assert.areEqual(false, response.HasError, 'No errors expected!');
        Assert.areEqual('Retrieve Account info successfuly', response.Message, 'An account record retrieved is expected!');

    }

    @isTest
    public static void getAccountInfo_AccountNotFound_Test() {
        //Given
        String accountId = null;
        createBaseRequest(accountId, 'GET');
        AccountManager.AccountInfoResponse response;

        //When
        try {
            Test.startTest();
                response = AccountManager.getAccountInfo();
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        //Then
        Assert.areEqual(true, response.HasError, 'Errors expected!');
        Assert.isNull(response.AccountInfo.AccountRecord, 'Account record not found!');

    }


    @isTest
    public static void postAccountInfo_AccountCreated_Test() {
        //Given
        Account accountRecord = new Account(
            Name              = 'Account Test REST API',
            Rating            = 'Hot',
            Industry          = 'Education',
            Description       = 'Account Description Test',
            Phone             = '998855885566',
            Fax               = '998855885566'
        );

        Contact contactRecord = new Contact (
            FirstName       = 'Test',
            LastName        = 'Test LastName',
            Email           = 'test@email.com',
            Phone           = '998855885566'
        );

        Case caseRecord = new Case (
            Subject     = 'Test REST API',
            Description = 'Test REST API Description',
            Status      = 'Open'
        );

        createBaseRequest('', 'POST');
        AccountManager.AccountInfoResponse response;
        AccountManager.AccountInfoWrapper accountInfo = new AccountManager.AccountInfoWrapper(
            accountRecord, 
            new List<Contact>{contactRecord}, 
            new List<Case>{caseRecord}
        );

        //When
        try {
            Test.startTest();
                response = AccountManager.postAccountInfo(accountInfo);
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }
      
        //Then
        Assert.areEqual(false, response.HasError, 'No errors expected!');
        Assert.areEqual('Account Create successfully', response.Message);
        Assert.areEqual(1, response.AccountInfo.Contacts.size(), 'One contact related to account was created!');
        Assert.areEqual(1, response.AccountInfo.Cases.size(), 'One case related to account was created!');

    }

    @isTest
    public static void postAccountInfo_AccountNotCreated_Test() {
        //Given

        createBaseRequest('', 'POST');
        AccountManager.AccountInfoResponse response;
        AccountManager.AccountInfoWrapper accountInfo = new AccountManager.AccountInfoWrapper();
        
        //When
        try {
            Test.startTest();
                response = AccountManager.postAccountInfo(accountInfo);
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }
      
        //Then
        Assert.areEqual(true, response.HasError, 'Errors expected!');
        Assert.isNull(response.AccountInfo.Contacts, 'No one contact related to account was created!');
        Assert.isNull(response.AccountInfo.Cases, 'No one case related to account was created!');

    }

    @isTest
    public static void deleteAccountInfo_AccountFound_Test() {
        //Given
        String accountId = [SELECT Id FROM Account LIMIT 1].Id;
        createBaseRequest(accountId, 'DELETE');
        AccountManager.AccountInfoResponse response;

        //When
        try {
            Test.startTest();
                response = AccountManager.deleteAccountInfo();
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        //Then
        Assert.areEqual(false, response.HasError, 'No errors expected!');
        Assert.areEqual('Account record deleted successfully!', response.Message, 'An account record deleted is expected!');

    }
    
    @isTest
    public static void deleteAccountInfo_AccountNotFound_Test() {
        //Given
        String accountId = null;
        createBaseRequest(accountId, 'DELETE');
        AccountManager.AccountInfoResponse response;

        //When
        try {
            Test.startTest();
                response = AccountManager.deleteAccountInfo();
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        //Then
        Assert.areEqual(true, response.HasError, 'Errors expected!');
        Assert.isNull(response.AccountInfo.AccountRecord, 'Account record not found!');

    }

    @isTest
    public static void updateAccountInfo_AccountFound_Test() {
        //Given
        Account accountRecord = new Account(
            Name              = 'Account Test REST API',
            Rating            = 'Hot',
            Industry          = 'Education',
            Description       = 'Account Description Test',
            Phone             = '998855885566',
            Fax               = '998855885566'
        );

        Contact contactRecord = new Contact (
            FirstName       = 'Test',
            LastName        = 'Test LastName',
            Email           = 'test@email.com',
            Phone           = '998855885566'
        );

        Case caseRecord = new Case (
            Subject     = 'Test REST API',
            Description = 'Test REST API Description',
            Status      = 'Open'
        );

        String accountId = [SELECT Id FROM Account LIMIT 1].Id;
        createBaseRequest(accountId, 'PATCH');
        AccountManager.AccountInfoResponse response;
        AccountManager.AccountInfoWrapper accountInfo = new AccountManager.AccountInfoWrapper(
            accountRecord, 
            new List<Contact>{contactRecord}, 
            new List<Case>{caseRecord}
        );

        //When
        try {
            Test.startTest();
                response = AccountManager.updateAccountInfo(accountInfo);
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        
        //Then
        Assert.areEqual(false, response.HasError, 'No errors expected!');
        Assert.areEqual('Account record update successfully', response.Message);

    }
    
    @isTest
    public static void updateAccountInfo_AccountNotFound_Test() {
        //Given
        String accountId = null;
        createBaseRequest(accountId, 'PATCH');
        AccountManager.AccountInfoResponse response;
        AccountManager.AccountInfoWrapper accountInfo = new AccountManager.AccountInfoWrapper();

        //When
        try {
            Test.startTest();
                response = AccountManager.updateAccountInfo(accountInfo);
            Test.stopTest();
        } catch (Exception e) {
           response = new AccountManager.AccountInfoResponse(e);
        }

        //Then
        Assert.areEqual(true, response.HasError, 'Errors expected!');
        Assert.isNull(response.AccountInfo.AccountRecord, 'Account record not found!');

    }

    public static void createBaseRequest(String URIComplement, String HTTPMethod) {
        RestRequest request  = new RestRequest();
        request.requestURI   = BASE_URL + URIComplement;
        request.httpMethod   = HTTPMethod;
        RestContext.request  = request;
    }
}
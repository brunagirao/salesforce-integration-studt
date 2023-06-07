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
    public static void getAccountInfo_Success_Test() {
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


    public static void createBaseRequest(String URIComplement, String HTTPMethod) {
        RestRequest request  = new RestRequest();
        request.requestURI   = BASE_URL + URIComplement;
        request.httpMethod   = HTTPMethod;
        RestContext.request  = request;
    }
}
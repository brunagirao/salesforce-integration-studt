/************************************************************************************************
* Name      : AccountPlanner
* Purpose   : Class to test SOAP API
* Author    : Bruna Girão
* Date      : 12-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-06-2023          Bruna Girão             create class 
***************************************************************************************************/

global with sharing class AccountPlanner {
    
    webservice static String fullName(String firstName, String lastName) {
        return 'Welcome ' + firstName + ' ' + lastName;
        
    }


    webservice static AccountInfoWrapper createAccount(AccountInfoWrapper accountInfoWrapper) {

        Account acc = new Account (
            Name            = accountInfoWrapper.Name,
            Rating          = accountInfoWrapper.Rating,
            Industry        = accountInfoWrapper.Industry,
            Phone           = accountInfoWrapper.Phone,
            AccountNumber   = accountInfoWrapper.AccountNumber
        );

        insert acc;
        return accountInfoWrapper;
    }
    

    global class AccountInfoWrapper {
        webservice String Name;
        webservice String Rating;
        webservice String Industry;
        webservice String Phone;
        webservice String AccountNumber;

        global AccountInfoWrapper() {}

    }



    /** XML To use
     * PATH (Workbench / Postman): <instanceorg>/services/Soap/class/AccountPlanner
     * HEADER
        Content-Type: text/xml; charset=UTF-8
        Accept: text/xml
        SOAPAction: '';
    
     *  BODY | fullName method
        <?xml version="1.0" encoding="UTF-8"?>
        <soapenv:Envelope 
            xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:accp="http://soap.sforce.com/schemas/class/AccountPlanner">
            
            <soapenv:Header>
                <accp:SessionHeader>
                    <accp:sessionId>
                         get your Salesforce section Id
                    </accp:sessionId>
                </accp:SessionHeader>
            </soapenv:Header>
            
            <soapenv:Body>
                <accp:fullName>
                    <accp:firstName>Bruna</accp:firstName>
                    <accp:lastName>Girão</accp:lastName>
                </accp:fullName>
            </soapenv:Body>
        </soapenv:Envelope>
     * 
     *  BODY | createAccount method
     * <?xml version="1.0" encoding="UTF-8"?>
        <soapenv:Envelope 
            xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:accp="http://soap.sforce.com/schemas/class/AccountPlanner">
            
            <soapenv:Header>
                <accp:SessionHeader>
                    <accp:sessionId> 
                        get your Salesforce section Id
                    </accp:sessionId>
                </accp:SessionHeader>
            </soapenv:Header>
            
            <soapenv:Body>
                <accp:createAccount>
                        <accp:accountInfoWrapper>
                            <accp:Name>Bruna</accp:Name>
                            <accp:Rating>Test</accp:Rating>
                            <accp:Phone>99999999999</accp:Phone>
                            <accp:Industry>Education</accp:Industry>
                            <accp:AccountNumber>123456</accp:AccountNumber>
                        </accp:accountInfoWrapper>
                </accp:createAccount>
            </soapenv:Body>
        </soapenv:Envelope>
     */

}


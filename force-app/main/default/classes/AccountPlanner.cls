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



    /** XML To use
     * PATH (Workbench / Postman): <instanceorg>/services/Soap/class/AccountPlanner
     * HEADER
        Content-Type: texy/xml; charset=UTF-8
        Accept: text/xml
        SOAPAction: '';
    
     *  BODY
        <?xml version="1.0" encoding="UTF-8"?>
        <soapenv:Envelope 
            xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:accp="http://soap.sforce.com/schemas/class/AccountPlanner">
            
            <soapenv:Header>
                <accp:SessionHeader>
                    <accp:sessionId>
                        
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
     */

}


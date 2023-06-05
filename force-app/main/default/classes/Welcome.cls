/************************************************************************************************
* Name      : Welcome
* Purpose   : Class to test REST API
* Author    : Bruna Girão
* Date      : 02-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
02-06-2023          Bruna Girão             create class 
***************************************************************************************************/

@RestResource(urlMapping='/v1/Welcome/*')
global with sharing class Welcome {
    
    global final static String WELCOME_MESSAGE = 'Welcome to REST API study';

    @HttpGet
    global static String getGreetingMessage() {
        return WELCOME_MESSAGE;
    } 

    @HttpPost
    global static String postGreetingMessage() {
        return  WELCOME_MESSAGE;
    }

    @HttpPatch
    global static String patchGreetingMessage() {
        return  WELCOME_MESSAGE + ' UPDATE WITH PATCH!';
    }

}
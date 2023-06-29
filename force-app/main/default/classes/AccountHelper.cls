/************************************************************************************************
* Name      : AccountHelper
* Purpose   : Helper class to Account Trigger
* Author    : Bruna Girão
* Date      : 19-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
19-06-2023         Bruna Girão             create class 
19-06-2023         Bruna Girão             add fillLocationCoordinatesFields() method
20-06-2023         Bruna Girão             add fillShippingAddressFields() method
***************************************************************************************************/
public with sharing class AccountHelper {
    
    /**
    * @description Method responsible to fill the Account Coordinate Location fields
                   based on Shipping Address fields.
    * @param newRecordsMap 
    * @param oldRecordsMap 
    **/
    public static void fillLocationCoordinatesFields(Map<Id, Account> newRecordsMap, Map<Id, Account> oldRecordsMap) {
        System.debug('======= AccountHelper | fillLocationCoordinatesFields');
        Set<Id> accountIdsSet = new Set<Id>();

        if(oldRecordsMap != null) {

            for(Id accountKey : newRecordsMap.keySet()) {
                Account newAccount = newRecordsMap.get(accountKey);
                Account oldAccount = oldRecordsMap.get(accountKey);

                if(hasAddressFieldsChanged(newAccount, oldAccount)) {
                    accountIdsSet.add(accountKey);
                }
            }

        } else {
            accountIdsSet.addAll(newRecordsMap.keySet());
        }

        if(!accountIdsSet.isEmpty()) {
            OpenCageGeocoderService.getForwardGeoCode(accountIdsSet);
        }

    }

    /**
    * @description Method responsible to fill the Account Shipping Address fields
                   based on the Latitute and Longitude fields.
    * @param newRecordsMap 
    * @param oldRecordsMap 
    **/
    public static void fillShippingAddressFields(Map<Id, Account> newRecordsMap, Map<Id, Account> oldRecordsMap) {
        System.debug('======= AccountHelper | fillShippingAddressFields');
        Set<Id> accountIdsSet = new Set<Id>();

        if(oldRecordsMap != null) {

            for(Id accountKey : newRecordsMap.keySet()) {
                Account newAccount = newRecordsMap.get(accountKey);
                Account oldAccount = oldRecordsMap.get(accountKey);

                if(hasCoordinatesFieldsChanged(newAccount, oldAccount)) {
                    accountIdsSet.add(accountKey);
                }
            }

        } else {
            accountIdsSet.addAll(newRecordsMap.keySet());
        }

        if(!accountIdsSet.isEmpty()) {
            OpenCageGeocoderService.getReverseGeoCode(accountIdsSet);
        }

    }

    /**
    * @description Method reponsible to verify is the Address infos has changed.
    * @param newAccount 
    * @param oldAccount 
    * @return Boolean 
    **/
    private static Boolean hasAddressFieldsChanged(Account newAccount, Account oldAccount) {
        
        return  newAccount.ShippingStreet     != oldAccount.ShippingStreet     ||
                newAccount.ShippingCity       != oldAccount.ShippingCity       ||
                newAccount.ShippingState      != oldAccount.ShippingState      ||
                newAccount.ShippingPostalCode != oldAccount.ShippingPostalCode ||
                newAccount.ShippingCountry    != oldAccount.ShippingCountry;
    }

    /**
    * @description  Method reponsible to verify is the Coordinate infos has changed.
    * @param newAccount 
    * @param oldAccount 
    * @return Boolean 
    **/
    private static Boolean hasCoordinatesFieldsChanged(Account newAccount, Account oldAccount) {
        return  newAccount.Location__latitude__s  != oldAccount.Location__latitude__s     ||
                newAccount.Location__longitude__s != oldAccount.Location__longitude__s;
    }
}
/************************************************************************************************
* Name      : AccountTriggerHandler
* Purpose   : Handler to Account Trigger
* Author    : Bruna Girão
* Date      : 19-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
19-06-2023         Bruna Girão             create class 
20-06-2023         Bruna Girão             extended to Trigger Handler Pattern and add methods
***************************************************************************************************/
public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        System.debug('========== BEFORE INSERT =========');
    }

    public override void afterInsert() {
        System.debug('========== AFTER INSERT =========');
        //AccountHelper.fillLocationCoordinatesFields((Map<Id, Account>)Trigger.newMap, (Map<Id, Account>)Trigger.oldMap);
        //AccountHelper.fillShippingAddressFields((Map<Id, Account>)Trigger.newMap, (Map<Id, Account>)Trigger.oldMap);
    }

    public override void beforeUpdate() {
        System.debug('========== BEFORE UPDATE =========');
        
    }

    public override void afterUpdate() {
        System.debug('========== AFTER UPDATE =========');
        //AccountHelper.fillLocationCoordinatesFields((Map<Id, Account>)Trigger.newMap, (Map<Id, Account>)Trigger.oldMap);
        //AccountHelper.fillShippingAddressFields((Map<Id, Account>)Trigger.newMap, (Map<Id, Account>)Trigger.oldMap);
    }

    public override void beforeDelete() {
        System.debug('========== BEFORE DELETE =========');
    }

    public override void afterDelete() {
        System.debug('========== AFTER DELETE =========');
    }

}
/************************************************************************************************
* Name      : AccountTrigger
* Purpose   : Trigger to Account Object
* Author    : Bruna Girão
* Date      : 19-06-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
19-06-2023         Bruna Girão             create trigger 
***************************************************************************************************/
trigger AccountTrigger on Account (
    before insert, before update, before delete,
    after insert, after update, after delete, after undelete
) {
    System.debug('======= AccountTrigger ========');
    new AccountTriggerHandler().run();

}
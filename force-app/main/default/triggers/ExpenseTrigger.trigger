trigger ExpenseTrigger on Expense__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    TriggerHandler.run(new ExpenseTriggerHandler(), Trigger.operationType);
}
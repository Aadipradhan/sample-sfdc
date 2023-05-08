public class ExpenseTriggerHandler implements TriggerInterface {
    public static void beforeInsert(List<Expense__c> newExpenseList){
        
        
    }
    
    public static void afterInsert(List<Expense__c> newExpenseList, Map<Id,SObject> newExpenseMap){
        Set<Id> contactIds = new Set<Id>();
        
        for(Expense__c newExp : newExpenseList){
            if(newExp.Amount__c != null && newExp.Contact__c != null){
                contactIds.add(newExp.Contact__c);
            }
        }
        
        if(!contactIds.isEmpty()){
            ExpenseTriggerHandlerHelper.updateExpenseOnAccount(contactIds);
        }
        
        
        
    }
    
    public static void beforeUpdate(Map<Id,SObject> newExpenseMap, Map<Id,SObject> oldExpenseMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newExpenseMap, Map<Id,SObject> oldExpenseMap){
        Set<Id> contactIds = new Set<Id>();
        
        for(Expense__c newExp : (List<Expense__c>)newExpenseMap.values()){
            Expense__c oldExp = (Expense__c) oldExpenseMap.get(newExp.Id);
            if(newExp.Amount__c != null && newExp.Contact__c != null && oldExp.Amount__c != newExp.Amount__c){
                contactIds.add(newExp.Contact__c);
            }
        }
        
        if(!contactIds.isEmpty()){
            ExpenseTriggerHandlerHelper.updateExpenseOnAccount(contactIds);
        }
        
    }
    
    public static void beforeDelete(List<Expense__c> oldExpenseList, Map<Id,SObject> oldExpenseMap){
        
    }
    
    public static void afterDelete(List<Expense__c> oldExpenseList, Map<Id,SObject> oldExpenseMap){
        Set<Id> contactIds = new Set<Id>();
        
        for(Expense__c oldExp : oldExpenseList){
            if(oldExp.Amount__c != null && oldExp.Contact__c != null){
                contactIds.add(oldExp.Contact__c);
            }
        }

        if(!contactIds.isEmpty()){
            ExpenseTriggerHandlerHelper.updateExpenseOnAccount(contactIds);
        }
        
    }
    public static void afterUnDelete(List<Expense__c> newExpenseList, Map<Id,SObject> newExpenseMap){
        
    }
}
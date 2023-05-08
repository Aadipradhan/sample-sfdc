public class AccountTriggerHandler implements TriggerInterface {
    public static void beforeInsert(List<Account> newAccountList){
        
        
    }
    
    public static void afterInsert(List<Account> newAccountList, Map<Id,SObject> newAccountMap){
        List<Account> accList = new List<Account>();
        
        for(Account newAcc : newAccountList){
            if(newAcc.Create_Related_Contact__c == true){ // create new contact
                accList.add(newAcc);
            }
        }
        
        //call helperMethod to create contact
        if(!accList.isEmpty()){
            AccountTriggerHandlerHelper.createContactsOfAccount(accList);    
        }
        
    }
    
    public static void beforeUpdate(Map<Id,SObject> newAccountMap, Map<Id,SObject> oldAccountMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newAccountMap, Map<Id,SObject> oldAccountMap){
        
        Map<Id,String> accIdandPhoneMap = new Map<Id,String>();
        List<Account> accList = new List<Account>();
        
        for(Account newAcc : (List<Account>) newAccountMap.values()){
            Account oldAcc = (Account) oldAccountMap.get(newAcc.Id);
            if(newAcc.Phone != oldAcc.Phone){ // contact - account phone update
                accIdandPhoneMap.put(newAcc.Id,newAcc.Phone); 
            } 
            if(oldAcc.Create_Related_Contact__c == false && newAcc.Create_Related_Contact__c == true){ // create new contact
                accList.add(newAcc);
            }
        }
        
        //Call helperMethod to update it in database
        if(!accIdandPhoneMap.isEmpty()){
            AccountTriggerHandlerHelper.updatePhoneFieldOfChildContact(accIdandPhoneMap);
        }
		
        //call helperMethod to create contacts
        if(!accList.isEmpty()){
            AccountTriggerHandlerHelper.createContactsOfAccount(accList);
        }
        
        
    }
    
    public static void beforeDelete(List<Account> oldAccountList, Map<Id,SObject> oldAccountMap){
        
    }
    
    public static void afterDelete(List<Account> oldAccountList, Map<Id,SObject> oldAccountMap){
        
    }
    
    public static void afterUnDelete(List<Account> newAccountList, Map<Id,SObject> newAccountMap){
        
    }
}
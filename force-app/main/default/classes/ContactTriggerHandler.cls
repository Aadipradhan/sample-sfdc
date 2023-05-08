public class ContactTriggerHandler implements TriggerInterface {
    
    public static void beforeInsert(List<Contact> newContactList){
        Set<Id> accIds = new Set<Id>();
        Set<Id> accIdsHavingMoreThanTwoCon = new Set<Id>();
        
        for(Contact newCon : newContactList){
            if(newCon.AccountId != null ){
                accIds.add(newCon.AccountId);
            }
        }
        

        
        for(Account acc :[Select Id,(Select Id from Contacts) from Account where Id IN :accIds]){
            if(acc.Contacts.size() >=2 ){
                accIdsHavingMoreThanTwoCon.add(acc.Id);
            }
        }
        
        for(Contact newCon : newContactList){
            if(accIdsHavingMoreThanTwoCon.contains(newCon.AccountId)){
                newCon.addError('Two Contacts already present for this associated account. You cannot add more contacts');
            }
        }
        
    }
    
    public static void afterInsert(List<Contact> newContactList, Map<Id,SObject> newContactMap){
        Set<Id> accountIdSet = new Set<Id>();
        
        
        for(Contact newContact :newContactList){
            if(newContact.AccountId != null || newContact.AccountId != '')
                accountIdSet.add(newContact.AccountId);
            
        }
        
        if(!accountIdSet.isEmpty()){
            ContactTriggerHandlerHelper.updateContactCountOnAccount(accountIdSet);
        }
        

    }
    
    public static void beforeUpdate(Map<Id,SObject> newContactMap, Map<Id,SObject> oldContactMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newContactMap, Map<Id,SObject> oldContactMap){
		
        Map<Id,String> accountIdandDescMap = new Map<Id,String>();
        List<Account> updateAccList = new List<Account>();
        
        for(Contact newCon : (List<Contact>) newContactMap.values()){
            Contact oldCon = (Contact) oldContactMap.get(newCon.Id);
            if(!String.isBlank(newCon.Description) && (newCon.Description != oldCon.Description) && newCon.AccountId != null){
                accountIdandDescMap.put(newCon.AccountId,newCon.Description); // contact-account description update
            }
        }
        
        //update description of account when contacts description is updated-- Start
        for(Account acc :[Select Id, Description from Account where Id IN :accountIdandDescMap.keySet()]){
            acc.Description = accountIdandDescMap.get(acc.Id);
            updateAccList.add(acc);
        }
        
        Database.update(updateAccList, false);
        //update description of account when contacts description is updated-- End
    }
    
    public static void beforeDelete(List<Contact> oldContactList, Map<Id,SObject> oldContactMap){
        
    }
    
    public static void afterDelete(List<Contact> oldContactList, Map<Id,SObject> oldContactMap){
        
        Set<Id> accountIdSet = new Set<Id>();
        
        for(Contact oldCon : (List<Contact>)oldContactMap.values()){
            if(oldCon.AccountId != null){ //check accountId for updating count
                accountIdSet.add(oldCon.AccountId);
            }
        }
        
        //call method to update the count of contact on Account
        if(!accountIdSet.isEmpty()){
            ContactTriggerHandlerHelper.updateContactCountonAccount(accountIdSet);
        }
        
    }
    
    public static void afterUnDelete(List<Contact> newContactList, Map<Id,SObject> newContactMap){
        
    }
}
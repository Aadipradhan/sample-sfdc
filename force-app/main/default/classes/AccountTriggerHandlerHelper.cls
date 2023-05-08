public class AccountTriggerHandlerHelper {
    

	
    // update phone field of all child contacts of account if account phone is updated
    public static void updatePhoneFieldOfChildContact(Map<Id,String> accIdandPhoneMap){ 
        List<Contact> updateContactList = new List<Contact>();
        
        for(Contact conObj :[Select Id, Phone, AccountId from Contact where AccountId IN :accIdandPhoneMap.keySet()]){
            conObj.Phone = accIdandPhoneMap.get(conObj.AccountId);
            updateContactList.add(conObj);
        }
        
        if(!updateContactList.isEmpty()){
        	Database.update(updateContactList, false);    
        }
        
    }
    
    //insert related contact if account checkbox is checked
    public static void createContactsOfAccount(List<Account> accList){
        
        List<Contact> insertContactList = new List<Contact>();
        
        for(Account accObj : accList){
            Contact contactObj = new Contact();
            contactObj.LastName = accObj.Name;
            contactObj.AccountId = accObj.Id;
            insertContactList.add(contactObj);
        }
        
		
        if(!insertContactList.isEmpty()){
            Database.insert(insertContactList, false);    
        }
        
    }
    
    
}
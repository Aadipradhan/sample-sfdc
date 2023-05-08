public class ContactTriggerHandlerHelper {
	
    public static void updateContactCountOnAccount(Set<Id> accIds){
        List<Account> updateAccList = new List<Account>();

        List<AggregateResult> contactCountList = [Select Count(Id) cnt, AccountId 
                                                  from Contact 
                                                  where AccountId IN :accIds 
                                                  Group By AccountId];
        for(AggregateResult argResult :contactCountList){
            Account accObj = new Account();
            accObj.Id = (Id)argResult.get('AccountId');
            accObj.Related_Contacts_Size__c = (Integer) argResult.get('cnt');
            updateAccList.add(accObj);
            
        }
        
        Database.update(updateAccList);

    }
}
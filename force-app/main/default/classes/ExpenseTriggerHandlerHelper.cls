public class ExpenseTriggerHandlerHelper {
    
    public static void updateExpenseOnAccount(Set<Id> contactIds){
        List<Account> updateAccList = new List<Account>();
        Set<Id> accIds = new Set<Id>();


        for(Contact con :[Select Id, AccountId from Contact where Id IN :contactIds]){
            accIds.add(con.AccountId);
        }
        		
        for(AggregateResult agr : [Select Sum(Amount__c) total,Contact__r.AccountId accId from Expense__c where Contact__r.AccountId IN :accIds group by Contact__r.AccountId]){	
            Account accObj = new Account();
            accObj.Id = (Id)agr.get('accId');
            accObj.Total_Investment__c = (Decimal) agr.get('total');
            updateAccList.add(accObj);
        }

        if(!updateAccList.isEmpty()){
            Database.update(updateAccList,false);
        }
    }
}
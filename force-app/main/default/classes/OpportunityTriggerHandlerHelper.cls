public class OpportunityTriggerHandlerHelper {
    
    public static void updateOppAmountOnAccount(Set<Id> accIds){
        List<Account> updateAccList = new List<Account>();
        
        for(AggregateResult agrObj :[Select AccountId, Sum(Amount) total from Opportunity where AccountId IN :accIds Group By AccountId]){
            Account accObj = new Account();
            accObj.Id = (Id) agrObj.get('AccountId');
            accObj.Total_Opportunity_Amount__c = (Decimal) agrObj.get('total');
            updateAccList.add(accObj);
        }
        
        if(!updateAccList.isEmpty()){
            Database.update(updateAccList,false);
        }
    }
}
public class OppLineItemTriggerHandlerHelper {
	
    public static void updateOppLineItemCountOnAccount(Set<Id> oppIds){
        Map<Id,Integer> accountIdAndOppLineItemCountMap = new Map<Id,Integer>();
        List<Account> accountUpdateList = new List<Account>();
        
        for(Opportunity oppObj :[Select Id,AccountId,(Select Id from OpportunityLineItems where ListPrice > 50000) from Opportunity where Id IN :oppIds]){
            if(oppObj.AccountId != null){
                accountIdAndOppLineItemCountMap.put(oppObj.AccountId,oppObj.OpportunityLineItems.size());
            }
        }
        
        for(Account accObj :[Select Id,Opportunity_Line_Item_Count__c from Account where Id IN :accountIdAndOppLineItemCountMap.keySet()]){
            accObj.Opportunity_Line_Item_Count__c = accountIdAndOppLineItemCountMap.get(accObj.Id);
            accountUpdateList.add(accObj);
        }
        
        if(!accountUpdateList.isEmpty()){
            Database.update(accountUpdateList,false);
        }
    }
}
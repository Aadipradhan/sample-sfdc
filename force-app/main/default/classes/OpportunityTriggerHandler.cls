public class OpportunityTriggerHandler implements TriggerInterface{
    
    public static void beforeInsert(List<Opportunity> newOppList){
        
        
    }
    
    public static void afterInsert(List<Opportunity> newOppList, Map<Id,SObject> newOppMap){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity newOpp : newOppList){            
            if((newOpp.Amount != null) && (newOpp.AccountId != null)){ //check Opp AccountId
                accIds.add(newOpp.AccountId);
            }
        }
        
        //call method to update Opp Amount on Account
        if(!accIds.isEmpty()){
            OpportunityTriggerHandlerHelper.updateOppAmountOnAccount(accIds);
        }
    }
    
    public static void beforeUpdate(Map<Id,SObject> newOppMap, Map<Id,SObject> oldOppMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newOppMap, Map<Id,SObject> oldOppMap){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity newOpp : (List<Opportunity>)newOppMap.values()){
            Opportunity oldOpp = (Opportunity) oldOppMap.get(newOpp.Id);
            
            if((oldOpp.Amount != newOpp.Amount) && (newOpp.AccountId != null)){ //check Opp Amount
                accIds.add(newOpp.AccountId);
            }
        }

        //call method to update Opp Amount on Account
        if(!accIds.isEmpty()){
            OpportunityTriggerHandlerHelper.updateOppAmountOnAccount(accIds);
        }
        
        
        
    }	
    
    public static void beforeDelete(List<Opportunity> oldOppList, Map<Id,SObject> oldOppMap){
        
    }
    
    public static void afterDelete(List<Opportunity> oldOppList, Map<Id,SObject> oldOppMap){
        
    }
    
    public static void afterUnDelete(List<Opportunity> newOppList, Map<Id,SObject> newOppMap){
        
    }
    
}
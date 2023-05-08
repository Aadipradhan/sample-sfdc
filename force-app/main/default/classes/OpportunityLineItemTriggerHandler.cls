public class OpportunityLineItemTriggerHandler implements TriggerInterface {
    public static void beforeInsert(List<OpportunityLineItem> newOpportunityLineItemList){
    }
    
    public static void afterInsert(List<OpportunityLineItem> newOpportunityLineItemList, Map<Id,SObject> newOpportunityLineItemMap){
        Set<Id> oppIds = new Set<Id>();
        
        for(OpportunityLineItem newOppItem : newOpportunityLineItemList){
            if((newOppItem.ListPrice != null) && (newOppItem.ListPrice > 50000) && (newOppItem.OpportunityId != null) ){
                oppIds.add(newOppItem.OpportunityId);
            }
        }
        if(!oppIds.isEmpty()){
            OppLineItemTriggerHandlerHelper.updateOppLineItemCountOnAccount(oppIds);
        }
    }
    
    public static void beforeUpdate(Map<Id,SObject> newOpportunityLineItemMap, Map<Id,SObject> oldOpportunityLineItemMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newOpportunityLineItemMap, Map<Id,SObject> oldOpportunityLineItemMap){
        Set<Id> oppIds = new Set<Id>();
        
        for(OpportunityLineItem newOppItem :(List<OpportunityLineItem>)newOpportunityLineItemMap.values()){
            OpportunityLineItem oldOppItem = (OpportunityLineItem)oldOpportunityLineItemMap.get(newOppItem.Id);
            if((newOppItem.ListPrice != oldOppItem.ListPrice) && (newOppItem.ListPrice != null) && (newOppItem.ListPrice > 50000)){
                oppIds.add(newOppItem.OpportunityId);  
            }
        }
        
        if(!oppIds.isEmpty()){
            OppLineItemTriggerHandlerHelper.updateOppLineItemCountOnAccount(oppIds);
        }
        
        
    }
    
    public static void beforeDelete(List<OpportunityLineItem> oldOpportunityLineItemList, Map<Id,SObject> oldOpportunityLineItemMap){
        
    }
    
    public static void afterDelete(List<OpportunityLineItem> oldOpportunityLineItemList, Map<Id,SObject> oldOpportunityLineItemMap){
        
    }
    
    public static void afterUnDelete(List<OpportunityLineItem> newOpportunityLineItemList, Map<Id,SObject> newOpportunityLineItemMap){
        
    }
}
public interface TriggerInterface {
	
    void beforeInsert(List<SObject> newRecordsList);
    
   	void afterInsert(List<SObject> newRecordsList, Map<Id,SObject> newRecordMap);
    
    void beforeUpdate(Map<Id,SObject> newRecordMap, Map<Id,SObject> oldRecordMap);
    
    void afterUpdate(Map<Id,SObject> newRecordMap, Map<Id,SObject> oldRecordMap);
    
    void beforeDelete(List<SObject> oldRecordList, Map<Id,SObject> oldRecordMap);
    
    void afterDelete(List<SObject> oldRecordList, Map<Id,SObject> oldRecordMap);
    
    void afterUndelete(List<SObject> newRecordsList, Map<Id,SObject> newRecordMap);
}
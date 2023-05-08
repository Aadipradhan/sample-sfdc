public class CaseTriggerHandler implements TriggerInterface{
    
    public static void beforeInsert(List<Case> newCaseList){
       
        Set<String> modelSeqNameSet = new Set<String>();
        Map<String,String> modelNameandIdMap = new Map<String,String>();
        
        for(Case newCase : newCaseList){
            if(!String.isBlank(newCase.Model_Sequence__c)){
                modelSeqNameSet.add(newCase.Model_Sequence__c);
            }
        }
        System.debug('Set->'+modelSeqNameSet);
        for(Model__c model : [Select Id, Name from Model__c where Name IN :modelSeqNameSet]){
            modelNameandIdMap.put(model.Name,model.Id);
        }
        
        for(Case newCase : newCaseList){
            if(modelNameandIdMap.get(newCase.Model_Sequence__c) != null){
                newCase.Model__c = modelNameandIdMap.get(newCase.Model_Sequence__c);
            }
        }
    }
    
    public static void afterInsert(List<Case> newCaseList, Map<Id,SObject> newCaseMap){
     //   Map<Id,Case> newCaseMap = (Case)newCaseMap;
        for(Case c :newCaseList){
            System.debug('CMap->'+newCaseMap.get(c.Id));
        }
        System.debug('Map->'+newCaseMap);
    }
    
    public static void beforeUpdate(Map<Id,SObject> newCaseMap, Map<Id,SObject> oldCaseMap){
        
    }
    
    public static void afterUpdate(Map<Id,SObject> newCaseMap, Map<Id,SObject> oldCaseMap){
        
    }
    
    public static void beforeDelete(List<Case> oldCaseList, Map<Id,SObject> oldCaseMap){
        
    }
    
    public static void afterDelete(Map<Id,SObject> oldCaseMap){
        
    }
    
    public static void afterUnDelete(List<Case> newCaseList, Map<Id,SObject> newCaseMap){
        
    }
    
    
}
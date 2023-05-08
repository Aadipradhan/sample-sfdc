public class QuizzMaker {
    @AuraEnabled(cacheable = true)
    public static List<quesAnsWrapper> getQuestionSet(String topic){
        List<quesAnsWrapper> qaWrapperList = new List<quesAnsWrapper>();
        List<Question_Answer__c> qaList = [Select Id, Name, Question__c, Correct_Answer__c, Option1__c,Option2__c,Option3__c
                                           FROM Question_Answer__c where Topic__c = :topic];
        
        for(Question_Answer__c qaObj : qaList){
            quesAnsWrapper qaWrapper = new quesAnsWrapper();
            qaWrapper.uId = qaObj.Name;
            qaWrapper.ques = qaObj.Question__c;
            qaWrapper.correctAns = qaObj.Correct_Answer__c;
           // qaWrapper.options = new List<String>{qaObj.Option1__c,qaObj.Option2__c,qaObj.Option3__c,qaObj.Correct_Answer__c};
            List<String> optionsList = new List<String>();
            optionsList.add(qaObj.Option1__c);
            optionsList.add(qaObj.Option2__c);
            optionsList.add(qaObj.Option3__c);
            optionsList.add(qaObj.Correct_Answer__c);
            qaWrapper.options = optionsList;
            qaWrapperList.add(qaWrapper);        
        }
        System.debug('List-'+qaWrapperList);
        System.debug('List size-'+qaWrapperList.size());
        return qaWrapperList;
        
        // String a = JSON.serialize(qaWrapperList);
        //   return (List<quesAnsWrapper>)Json.deserializeUntyped(a);
        //  return a;
    }
    
    @AuraEnabled(cacheable = true)
    public static List<Question_Answer__c> fetchTopic(string searchKey){
         string searchKeyword = '%' + searchKey + '%';
      return [Select Id, Topic__c,Name, Question__c, Correct_Answer__c, Option1__c,Option2__c,Option3__c
                                           FROM Question_Answer__c where Topic__c LIKE :searchKeyword];
        
    }
    
    @AuraEnabled
    public static resultWrapper submitQnA(Map<String,String> userSelectedQnA){
        Map<String,String> correctQnAMap = new Map<String,String>();
        resultWrapper result = new resultWrapper(0,0);
        
        for(Question_Answer__c qnA :[Select Id,Name, Correct_Answer__c FROM Question_Answer__c where Name IN :userSelectedQnA.keySet()]){
            correctQnAMap.put(qnA.Name,qnA.Correct_Answer__c);
        } 
        
        for(String userAns : userSelectedQnA.keySet()){
            if(correctQnAMap.get(userAns).equalsIgnoreCase(userSelectedQnA.get(userAns))){
				 result.correctAns ++;
            }
            else{
                result.wrongAns ++;
            }
        }
        System.debug('result->'+result);
        return result;
        
        
    }
    
    
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountData(String searchKey){
        String key = '%'+searchKey+'%';
        return [Select Id,Name,Type,Phone from Account where Name LIKE :key];
    }
    
    public  class quesAnsWrapper {
        @AuraEnabled public String uId;
        @AuraEnabled public String ques;
        @AuraEnabled public String correctAns;
        @AuraEnabled public List<String> options;
    }
    
   
    public  class resultWrapper{
     @AuraEnabled   public Integer correctAns;
      @AuraEnabled  public Integer wrongAns;
        
        public resultWrapper(Integer correctAns,Integer wrongAns) {
            this.correctAns = correctAns;
            this.wrongAns = wrongAns;
        }
    }
}
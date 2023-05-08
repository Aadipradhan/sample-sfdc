import { LightningElement,track,wire,api } from 'lwc';
import fetchTopic from '@salesforce/apex/QuizzMaker.fetchTopic';
export default class FetchTopicQuiz extends LightningElement {

    searchKey = '';
    hideParent = true;
    flag = false;
    topics;
    value = "Value from Parent";
    showButton = false
    showChild = false;

    @wire(fetchTopic, { searchKey: '$searchKey' })
    gettopics({error,data}){
        if (data) {
            this.topics = data;
                this.error = undefined;
            if(this.searchKey != ''){
                this.flag = true;
                console.log('flag ',this.flag)
            } else if(this.searchKey == ''){
                this.flag = false;
                console.log('flag ',this.flag)
            }
           
        } else if (error) {
            this.error = error;
            this.topics = undefined;
        }
    }

    handleKeyChange(event) {
        const searchKey = event.target.value;
        console.log('searchKey ',searchKey);
            this.searchKey = searchKey;
            console.log('flag ',this.flag)
    }

    handleClick(event){

        console.log('Hi Click')
        console.log('value of show button',this.showButton);
        this.showButton = true;
       
        //this.searchKey = event.target.value;
    }

    handleClickQuiz(){

        this.showChild = true;
        this.hideParent = false;
        console.log('value of show Child',this.showChild);
    }
}
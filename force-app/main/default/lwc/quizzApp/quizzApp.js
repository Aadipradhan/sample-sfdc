import { LightningElement, wire } from 'lwc';
import getQuestionAndAns from '@salesforce/apex/QuizzMaker.getQuestionSet'
export default class QuizzApp extends LightningElement {

    topic
    quizzData
    showQuizzData




    handleInputTopic(event) {
        this.topic = event.target.value;
    }

    handleClick(event) {
        this.showQuizzData = false;
        getQuestionAndAns({ topic: this.topic })
            .then((data) => {
                console.log('OriginalData-', data);
                this.quizzData =  data.map((item) => {
                    let newArr = [...item.options]
                    let shuffledOptions = newArr.sort(() => 0.5 - Math.random())
                     return{...item,'options':shuffledOptions}
                })
                console.log('quizzData[0]-',this.quizzData[0]);
                console.log('quizzData-',JSON.stringify(this.quizzData[0]));
                this.showQuizzData = true;
            })
            .catch((error) => {
                console.log('Error', error);
            })
    }
}
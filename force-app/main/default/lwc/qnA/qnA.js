import { LightningElement, api } from 'lwc';
import submitQuizz from '@salesforce/apex/QuizzMaker.submitQnA';
import CONFETTI from '@salesforce/resourceUrl/confetti';
import { loadScript } from 'lightning/platformResourceLoader';
export default class QnA extends LightningElement {
    @api quizzData;
    currentQnA;
    currentQnAIndex;
    totalQuizzDataSize;
    nextDisabled = false;
    prevDisabled = true;
    showSubmitBtn = false;
    displayQuesNo;
    userSelectedQnA = {};
    result;
    showQuizz = true;
    showResult = false;
    progressValue;
    incDecValue = 0;



    connectedCallback() {
        console.log('connectedCalled: ');
        loadScript(this, CONFETTI + '?')
            .then(() => {
                console.log('ScriptLoaded ');
            })
            .catch((error) => {
                console.log('Error from loadscript : ', JSON.stringify(error));
            })
        this.currentQnA = (this.quizzData[0] != undefined) ? this.quizzData[0] : null;
        this.currentQnAIndex = (this.quizzData.length != 0) ? 0 : null;
        this.totalQuizzDataSize = (this.quizzData.length != 0) ? this.quizzData.length : 0;
        this.displayQuesNo = (this.quizzData.length != 0) ? 1 : null
        this.nextDisabled = (this.quizzData.length == 1) ? true : false;
        this.progressValue = 100 / this.totalQuizzDataSize;
        this.incDecValue = 100 / this.totalQuizzDataSize;
    }

    renderedCallback() {
        const styleElem = document.createElement("style");
        styleElem.innerText = `c-qn-A
    .slds-progress-bar__value {
        background : #892db9 !important;
    }`
        let progressBarStyle = this.refs.progressBar;
        if (progressBarStyle != null) progressBarStyle.appendChild(styleElem);
    }

    handleNext() {
        this.currentQnAIndex++ , this.displayQuesNo++;
        this.currentQnA = this.quizzData[this.currentQnAIndex];
        this.prevDisabled = false;
        this.nextDisabled = (this.currentQnAIndex == this.totalQuizzDataSize - 1) ? true : false;
        this.progressValue += this.incDecValue;
    }

    handlePrevious() {
        this.currentQnAIndex-- , this.displayQuesNo--;
        this.currentQnA = this.quizzData[this.currentQnAIndex];
        this.nextDisabled = false;
        this.prevDisabled = (this.currentQnAIndex == 0) ? true : false;
        this.progressValue -= this.incDecValue;

    }

    handleOptionSelect(event) {
        console.log('clicked : ');
        let ans = event.currentTarget.dataset.ans;
        let qId = event.currentTarget.dataset.qid;
        this.userSelectedQnA[qId] = ans;
        console.log('selectedOption : ', JSON.stringify(this.userSelectedQnA));
        this.showSubmitBtn = (Object.keys(this.userSelectedQnA).length == this.totalQuizzDataSize) ? true : false;
    }

    handleSubmit() {
        submitQuizz({ userSelectedQnA: this.userSelectedQnA })
            .then((data) => {
                this.result = data;
                this.showQuizz = false;
                this.showResult = true;
                console.log('result : ', this.result);
                console.log('result : ', JSON.stringify(this.result));
                confetti({
                    particleCount: 200,
                    startVelocity: 60,
                    spread: 300,
                    origin: {
                        y: 0.9
                    }
                });

            })
            .catch((error) => {
                console.log('Error from handleSubmit->', error);
            })
    }
}
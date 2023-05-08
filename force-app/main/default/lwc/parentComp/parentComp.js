import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    message

    handleChildEvent(event){
        console.log('parent called');
        this.message = event.detail;
        console.log('Message->',this.message);
    }
}
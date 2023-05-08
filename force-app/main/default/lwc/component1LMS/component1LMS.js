import { LightningElement, wire } from 'lwc';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/LMSchannel__c'
import { publish, MessageContext, createMessageContext } from 'lightning/messageService';

export default class Component1LMS extends LightningElement {
    text;
    context = createMessageContext();

    @wire(MessageContext)
    messageContext

    handleInputChange(event){
        this.text = event.target.value;
        console.log('Text->',this.text);    
    }

    handleSend(){
        const payLoad = {message:this.text,sourceComponent: "Comp-1"};
        console.log('Payload-',payLoad);
         publish(this.context,MESSAGE_CHANNEL,payLoad)
        console.log('pub->',publish(this.context,MESSAGE_CHANNEL,payLoad));
    }
}
import { LightningElement, wire } from 'lwc';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/LMSchannel__c'
import { subscribe,unsubscribe, MessageContext, APPLICATION_SCOPE } from 'lightning/messageService';

export default class Component2LMS extends LightningElement {

    receivedMessage = '';
    subscription = null;
    
    @wire(MessageContext)
    messageContext

    handleSubscribe(){
        console.log('subscribe-called');
        if(!this.subscription){
            this.subscription = subscribe(this.messageContext,MESSAGE_CHANNEL,
                (message) => this.handleMessage(message),
                {scope :APPLICATION_SCOPE})
        }
    }

    handleMessage(message){
        console.log('MessageReceived->',message);
        console.log('Message.msg->',message.message);
        this.receivedMessage = message.message;
    }
    // connectedCallback(){
    //     console.log('connectedCalled');
    //     this.handleSubscribe();
    //     console.log('Subscribe');
    // }
}
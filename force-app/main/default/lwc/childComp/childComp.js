import { LightningElement} from 'lwc';

export default class ChildComp extends LightningElement {

    handleClick(){
        let cusEvent = new CustomEvent('cusevent',{bubbles : true, detail : 'message from child received'});
        this.dispatchEvent(cusEvent);
        console.log('event dispatched',cusEvent);
    }
}
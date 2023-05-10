import { LightningElement, wire } from 'lwc';
import getAccData from '@salesforce/apex/QuizzMaker.getAccountData';
const COLUMNS = [{
    label : 'Account Name',
    fieldName : 'Name',
    type : 'text',
    sortable : true
},
{
    label : 'Type',
    fieldName : 'Type',
    sortable : true
},
{
    label : 'Phone',
    fieldName : 'Phone',
    sortable : true
}]
const DELAY = 500;
export default class DataTable extends LightningElement {

    accData;
    searchString ='';
    columns = COLUMNS
    timeout;
    

    @wire(getAccData,{searchKey : '$searchString'})
    getData({data,error}){
        if(data){
            this.accData = data;
        }
        else if(error){
            console.error('Error from fetching data',error)
        }
    }
    connectedCallback(){
        console.log('Test OK');
    }
    handleSearch(event){
        console.log('Added the log to test');
        let value = event.target.value;
        clearTimeout(this.timeout); 
        this.timeout = setTimeout(() => {   
                this.searchString = value
            },DELAY)
    }
}
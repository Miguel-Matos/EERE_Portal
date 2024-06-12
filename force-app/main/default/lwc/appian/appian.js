import { LightningElement, wire, track } from 'lwc';
import getRequest from '@salesforce/apex/AppianController.getRequest';

export default class Appian extends LightningElement {
  @track appianData = [];

  @wire(getRequest)
  wiredAppianData({ error, data }) {
    if (data) {
      try {
        this.appianData = JSON.parse(data);
        console.log(this.appianData);
      } catch (e) {
        console.error('Error parsing JSON data', e);
      }
    } else if (error) {
      console.error(error);
    }
  }
}

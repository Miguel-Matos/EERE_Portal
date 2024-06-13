import { LightningElement, wire, track } from 'lwc';
import getAccountInfo from '@salesforce/apex/AccountController.getAccountInfo';

export default class CustomerPortal extends LightningElement {
  @track account;
  @track error;

  @wire(getAccountInfo)
  wiredAccount({ error, data }) {
      if (data) {
          this.account = data;
          this.error = undefined;
      } else if (error) {
          this.account = undefined;
          this.error = error;
          console.error('Error fetching account information:', error);
      }
  }
}

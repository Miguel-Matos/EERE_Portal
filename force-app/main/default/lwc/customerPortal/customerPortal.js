import { LightningElement, wire, track } from 'lwc';
import getAccountInfo from '@salesforce/apex/AccountController.getAccountInfo';
import getApplicationInfo from '@salesforce/apex/ApplicationController.getApplicationInfo';

export default class CustomerPortal extends LightningElement {
  @track account;
  @track error;
  @track application;
  @track appError

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


  @wire(getApplicationInfo)
  wiredApp({ error, data }) {
      if (data) {
          this.application = data;
          this.appError = undefined;
      } else if (error) {
          this.application = undefined;
          this.appError = error;
          console.error('Error fetching application information:', error);
      }
  }
}

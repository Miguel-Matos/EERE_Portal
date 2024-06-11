import { LightningElement } from 'lwc';
import createInquiry from '@salesforce/apex/InquiryController.createInquiry';

export default class WebToCaseInquiry extends LightningElement {
  name = '';
  email = '';
  phone = '';
  subject = '';
  description = '';

  handleChange(e) {
    const field = e.currentTarget.dataset.id;
    if (field === 'name') {
      this.name = e.target.value;
    } else if (field === 'email') {
      this.email = e.target.value;
    } else if (field === 'phone') {
      this.phone = e.target.value;
    } else if (field === 'subject') {
      this.subject = e.target.value;
    } else if (field === 'description') {
      this.description = e.target.value;
    }
  }

  handleSubmit() {
    const inquiry = {
      Name: this.name,
      Email__c: this.email,
      Phone__c: this.phone,
      Subject__c: this.subject,
      Description__c: this.description
    };

    // Log the inquiry object to check its structure
    console.log('Inquiry object:', inquiry);

    createInquiry({ inq: inquiry })
      .then(result => {
        console.log('Result from Apex:', result); // Log the result from the server
      })
      .catch(error => {
        console.log('Error from Apex:', error.body.message); // Log the error message if there is an error
      });
  }
}
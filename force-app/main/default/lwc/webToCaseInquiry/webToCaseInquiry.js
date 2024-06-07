import { LightningElement } from 'lwc';
import createInquiry from '@salesforce/apex/InquiryController.createInquiry';

export default class WebToCaseInquiry extends LightningElement {
  name = '';
  email = '';
  phone = '';
  subject = '';
  description = '';



  handleChange(e) {
    e.preventDefault();
    const field = e.target.name;
    const val = e.target.value;

    if (field === 'name') {
      this.firstName = val;
    } else if (field === 'email') {
      this.lastName = val;
    } else if (field === 'phone') {
      this.lastName = val;
    } else if (field === 'subject') {
      this.lastName = val;
    } else if (field === 'description') {
      this.lastName = val;
    } 
  }

  handleSubmit() {
    const inquiry = {
      Name: this.name,
      Email__c: this.email,
      Phone__c: this.phone,
      Subject__c: this.subject,
      Description__c: this.description
    }
    console.log(inquiry);

    createInquiry({inquiry}).catch(error => console.log(error.body.message));
  }
}
import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createLead from '@salesforce/apex/LeadController.createLead';

export default class LeadForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track Company = '';
    @track Email = '';

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'Company') {
            this.Company = event.target.value;
        } else if(field === 'Email') {
            this.Email = event.target.value
        }
    }

    handleSubmit() {
        const lead = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Company: this.Company,
            Email: this.Email
        };

        createLead({ lead })
            .then(() => {
                this.showToast('Success', 'Lead created successfully', 'success');
                this.resetForm();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event);
    }

    resetForm() {
        this.firstName = '';
        this.lastName = '';
        this.Company = '';
        this.Email = '';
    }
}
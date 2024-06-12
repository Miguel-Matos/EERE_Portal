import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createLead from '@salesforce/apex/LeadController.createLead';

export default class LeadForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track Company = '';
    @track Email = '';
    // newly added
    @track AnnualRevenue = '';
    @track Type_of_work__c = '';
    @track Products_Services_Offered__c = '';
    @track Region__c = '';
    // @track NumberOfEmployees = '';
    
    regionOptions = [
        { label: 'North', value: 'North' },
        { label: 'East', value: 'East' },
        { label: 'South', value: 'South' },
        { label: 'West', value: 'West' }
    ];

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
        } else if(field === 'AnnualRevenue') { // newly added
            this.AnnualRevenue = event.target.value;
        } else if(field === 'Type_of_work__c') {
            this.Type_of_work__c = event.target.value;
        } else if(field === 'Products_Services_Offered__c') {
            this.Products_Services_Offered__c = event.target.value;
        } else if(field === 'Region__c') {
            this.Region__c = event.target.value;
        } //else if(field === 'NumberOfEmployees') {
            //this.NumberOfEmployees = event.target.value;
       //}
    }

    handleSubmit() {
        const lead = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Company: this.Company,
            Email: this.Email, 
            // newly added
            AnnualRevenue: this.AnnualRevenue,
            Type_of_work__c: this.Type_of_work__c,
            Products_Services_Offered__c: this.Products_Services_Offered__c,
            Region__c: this.Region__c,
            //NumberOfEmployees: parseInt(this.NumberOfEmployees, 10)
        };

        createLead({ lead })
            .then(() => {
                this.showToast('Success', 'Lead created successfully', 'success');
                this.resetForm();
                window.location.href = "https://eere3-dev-ed.develop.my.site.com/index/";
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

        this.AnnualRevenue = '';
        this.Type_of_work__c = '';
        this.Products_Services_Offered__c = '';
        this.Region__c = '';
        // this.NumberOfEmployees = '';
    }
}

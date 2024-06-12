import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

class LeadForm extends LightningElement {
    @api recordId;

    // Function to handle form submission
    handleSubmit(event) {
        event.preventDefault(); // Prevent the default form submission behavior
        const fields = this.template.querySelectorAll('lightning-input-field');

        // Collect the input data into a simple object
        let formData = {};
        fields.forEach(field => {
            formData[field.fieldName] = field.value;
        });

        // Optionally, you can do validation or manipulation of formData here

        // Example: Log the form data to the console (you might want to send this data to the server or process it further)
        console.log('Form Data:', formData);

        // Submit the data
        this.template.querySelector('lightning-record-edit-form').submit(formData);
    }

    // Handle success and error
    handleSuccess(event) {
        console.log('Record ID:', event.detail.id); // Record ID of the newly created record

        // Redirect to the specified URL in the same tab
        window.location.href = 'https://eere3-dev-ed.develop.my.site.com/index/';
    }

    handleError(event) {
        console.log('Error:', event.detail); // Error detail
        // Additional error handling actions
    }
}

export default NavigationMixin(LeadForm);

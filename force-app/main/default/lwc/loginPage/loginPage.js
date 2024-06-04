import { LightningElement, track } from 'lwc';
import authenticateUser from '@salesforce/apex/LoginController.authenticateUser';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LoginForm extends LightningElement {
    @track username = '';
    @track password = '';

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'username') {
            this.username = event.target.value;
        } else if (field === 'password') {
            this.password = event.target.value;
        }
    }

    handleLogin() {
        console.log('Login button clicked'); // Debug log

        authenticateUser({ username: this.username, password: this.password })
            .then(result => {
                console.log('Authentication result:', result); // Debug log

                if (result.success) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Login successful',
                            variant: 'success'
                        })
                    );
                    // Log the URL before redirection
                    const redirectUrl = '/LeadForm';
                    console.log('Redirecting to:', redirectUrl);
                    // Redirect to the specified page within the Experience Site
                    window.location.href = redirectUrl;
                } else {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: result.errorMessage,
                            variant: 'error'
                        })
                    );
                }
            })
            .catch(error => {
                console.error('Authentication error:', error); // Debug log
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}

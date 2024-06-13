import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccountInfo from '@salesforce/apex/AccountController.getAccountInfo';
import getApplicationInfo from '@salesforce/apex/ApplicationController.getApplicationInfo';
import uploadFile from '@salesforce/apex/UploadController.uploadFile';

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

  handleUploadFinished(event) {
    const uploadedFiles = event.detail.files;

    uploadedFiles.forEach(file => {
        uploadFile({ fileName: file.name, contentVersionId: file.documentId })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'File uploaded successfully',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error uploading file',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    });
}
}

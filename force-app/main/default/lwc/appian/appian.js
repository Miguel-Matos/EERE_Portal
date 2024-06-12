import { LightningElement, wire, track } from 'lwc';
import getRequest from '@salesforce/apex/AppianController.getRequest';

export default class Appian extends LightningElement {
  @track appianData = [];
  @track isLoading = true;
  @track error;

  columns = [
    { label: 'Title', fieldName: 'title', type: 'text' },
    { label: 'Description', fieldName: 'description', type: 'text' },
    { label: 'Modified', fieldName: 'modified', type: 'date' },
    { label: 'Access Level', fieldName: 'accessLevel', type: 'text' }
  ];

  @wire(getRequest)
  wiredAppianData({ error, data }) {
    if (data) {
      try {
        const parsedData = JSON.parse(data);
        this.appianData = parsedData.map(item => ({
          _id: item._id.$oid,
          title: item.title,
          description: item.description,
          modified: item.modified,
          accessLevel: item.accessLevel
        }));
        this.isLoading = false;
        console.log('Data fetched successfully:', this.appianData);
      } catch (e) {
        console.error('Error parsing JSON data', e);
        this.error = e;
        this.isLoading = false;
      }
    } else if (error) {
      console.error('Error fetching data', error);
      this.error = error;
      this.isLoading = false;
    }
  }
}

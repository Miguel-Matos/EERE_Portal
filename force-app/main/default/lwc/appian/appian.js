import { LightningElement, wire, track } from 'lwc';
import getRequest from '@salesforce/apex/AppianController.getRequest';

export default class Appian extends LightningElement {
  @track appianData = [];
  @track filteredData = [];
  @track isLoading = true;
  @track error;
  @track searchTerm = '';
  @track selectedColumns = ['title', 'description', 'modified', 'accessLevel'];

  // Prepares the table categories
  allColumns = [
    { label: 'Title', fieldName: 'title', type: 'text' },
    { label: 'Description', fieldName: 'description', type: 'text' },
    { label: 'Modified', fieldName: 'modified', type: 'date' },
    { label: 'Access Level', fieldName: 'accessLevel', type: 'text' },
    { label: 'Identifier', fieldName: 'identifier', type: 'text' },
    { label: 'Publisher', fieldName: 'publisherName', type: 'text' },
    { label: 'Contact', fieldName: 'contactName', type: 'text' },
    { label: 'Email', fieldName: 'contactEmail', type: 'email' },
    { label: 'Landing Page', fieldName: 'landingPage', type: 'url' },
    { label: 'Spatial', fieldName: 'spatial', type: 'text' },
    { label: 'Temporal', fieldName: 'temporal', type: 'text' },
    { label: 'Keywords', fieldName: 'keywords', type: 'text' },
    { label: 'Bureau Code', fieldName: 'bureauCode', type: 'text' },
    { label: 'Program Code', fieldName: 'programCode', type: 'text' },
    { label: 'Theme', fieldName: 'theme', type: 'text' }
  ];

  get comboboxOptions() {
    return this.allColumns.map(col => ({ label: col.label, value: col.fieldName }));
  }

  get columns() {
    return this.allColumns.filter(col => this.selectedColumns.includes(col.fieldName));
  }

  // Gets data from the appian controller and assigns to the appianData and filteredData
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
          accessLevel: item.accessLevel,
          identifier: item.identifier,
          publisherName: item.publisher.name,
          contactName: item.contactPoint.fn,
          contactEmail: item.contactPoint.hasEmail,
          landingPage: item.landingPage,
          spatial: item.spatial,
          temporal: item.temporal,
          keywords: item.keyword.join(', '),
          bureauCode: item.bureauCode.join(', '),
          programCode: item.programCode.join(', '),
          theme: item.theme
        }));
        this.filteredData = this.appianData;
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



  // Next 3 methods are for changing the table content and data when using the search and select columns feature
  handleSearch(event) {
    this.searchTerm = event.target.value.toLowerCase();
    this.filterData();
  }

  handleColumnSelection(event) {
    this.selectedColumns = event.detail.value;
  }

  filterData() {
    if (this.searchTerm) {
      this.filteredData = this.appianData.filter(item =>
        Object.values(item).some(value =>
          String(value).toLowerCase().includes(this.searchTerm)
        )
      );
    } else {
      this.filteredData = this.appianData;
    }
  }
}

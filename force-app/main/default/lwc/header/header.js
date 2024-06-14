import { LightningElement } from 'lwc';

export default class Header extends LightningElement {
    // Method to handle sign in navigation
    handleSignIn() {
        window.open('https://eere3-dev-ed.develop.my.site.com/userLogin', '_blank');
    }
}

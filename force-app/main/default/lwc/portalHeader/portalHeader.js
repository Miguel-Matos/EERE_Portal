import { LightningElement } from "lwc";

export default class PortalHeader extends LightningElement {
  handleSignOut() {
    window.open("https://eere3-dev-ed.develop.my.site.com/index", "_blank");
  }
}

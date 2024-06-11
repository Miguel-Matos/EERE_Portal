public with sharing class Appian {
    public Appian() {

    }

    public static void getRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Appian_EERE_Endpoint_Credentials/suite/webapi/articles');

        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
    }
}
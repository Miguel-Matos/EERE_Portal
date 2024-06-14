@isTest
public class AppianControllerTest {
    private class MockHttpResponseGenerator implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"articles": [{"id": 1, "Appian": "This is an Appian Test"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetRequest() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        String responseBody = AppianController.getRequest();
        
        System.assertEquals('{"articles": [{"id": 1, "Appian": "This is an Appian Test"}]}', responseBody);
    }
}

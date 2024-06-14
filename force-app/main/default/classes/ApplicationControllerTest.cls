@isTest
public class ApplicationControllerTest {
    @testSetup
    static void setupTestData() {
        // Create a test Application
        Application__c testApplication = new Application__c(
            Name = 'Son Goku',
            Stage__c = 'Concept Paper',
            Phone__c = '1111111111',
            Company__c = 'Denki Houdai',
            Description__c = 'We develop solar powered hot dogs',
            Annual_Revenue__c = 1000000,
            Email__c = 'mmatos@skillstorm.com',
            NumberOfEmployees__c = 5000
        );
        insert testApplication;

        // Create a test User
        User testUser = new User(
            Username = 'Toph@beifong.com',
            Email = 'Toph@beifong.com',
            LastName = 'Beifong',
            Alias = 'tBei',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            Application__c = testApplication.Id
        );
        insert testUser;
    }

    @isTest
    static void testPositive() {

        User testUser = [SELECT Id FROM User WHERE Username = 'Toph@beifong.com' LIMIT 1];


        System.runAs(testUser) {
            Application__c result = ApplicationController.getApplicationInfo();

            System.assertNotEquals(null, result);
            System.assertEquals('Son Goku', result.Name);
            System.assertEquals('Concept Paper', result.Stage__c);
            System.assertEquals('1111111111', result.Phone__c);
            System.assertEquals('Denki Houdai', result.Company__c);
            System.assertEquals('We develop solar powered hot dogs', result.Description__c);
            System.assertEquals(1000000, result.Annual_Revenue__c);
            System.assertEquals('mmatos@skillstorm.com', result.Email__c);
            System.assertEquals(5000, result.NumberOfEmployees__c);
        }
    }

    @isTest
    static void testNegative() {


        User testUser2 = new User(
            Username = 'Toph2@beifong.com',
            Email = 'Toph2@beifong.com',
            LastName = 'Beifong',
            Alias = 'tBei',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser2;

        System.runAs(testUser2) {
            Application__c result = ApplicationController.getApplicationInfo();

            System.assertEquals(null, result);
        }
    }
}

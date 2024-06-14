@isTest
public class AccountControllerTest {
    @testSetup
    static void setupTestData() {

        Account testAccount = new Account(
            Name = 'Skid McMarks',
            Industry = 'Technology',
            Phone = '1234567890',
            Website = 'www.iAmSoTired.com'
        );
        insert testAccount;

        
        User testUser = new User(
            Username = 'Toph@beifong.com',
            Email = 'Toph@beifong.com',
            LastName = 'Beifong',
            Alias = 'tBei',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            Account__c = testAccount.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
    }

    @isTest
    static void testGetAccountInfo_WithAccount() {

        User testUser = [SELECT Id FROM User WHERE Username = 'Toph@beifong.com' LIMIT 1];

        System.runAs(testUser) {
            Account result = AccountController.getAccountInfo();

            System.assertNotEquals(null, result);
            System.assertEquals('Skid McMarks', result.Name);
            System.assertEquals('Technology', result.Industry);
            System.assertEquals('1234567890', result.Phone);
            System.assertEquals('www.iAmSoTired.com', result.Website);
        }
    }

    @isTest
    static void testGetAccountInfo_WithoutAccount() {

        User testUserNoAcc = new User(
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
        insert testUserNoAcc;


        System.runAs(testUserNoAcc) {

            Account result = AccountController.getAccountInfo();


            System.assertEquals(null, result);
        }
    }
}

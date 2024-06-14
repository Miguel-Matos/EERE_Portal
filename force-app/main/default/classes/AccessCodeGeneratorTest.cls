@IsTest
public class AccessCodeGeneratorTest {

    @IsTest
    static void testGenerateAccessCode() {
        // Call the method to generate the access code
        String accessCode = AccessCodeGenerator.generateAccessCode();

        // Assert that the access code is not null
        System.assertNotEquals(null, accessCode, 'Access code should not be null');

        // Assert that the length of the access code is 10
        System.assertEquals(10, accessCode.length(), 'Access code should be 10 characters long');
    }

    @IsTest
    static void testSendAccessCodeEmail() {
        // Setup test data
        String testEmail = 'test@example.com';
        String accessCode = 'ABCDE12345'; // Normally, this should be generated dynamically

        // Prepare a test email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{ testEmail });
        mail.setSubject('Your Access Code');
        mail.setPlainTextBody('Congratulations! Here is your access code: ' + accessCode + '\nPlease use this as your temporary password to log in and reset your password.');

        // Call the method to send an email
        Test.startTest();
        AccessCodeGenerator.sendAccessCodeEmail(testEmail, accessCode);
        Test.stopTest();

        // Retrieve the email results after Test.stopTest to ensure proper test execution
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail }, false);
        
        // Assert that an email was attempted to send
        System.assertNotEquals(null, results, 'Email results should not be null');
        System.assertEquals(true, results[0].isSuccess(), 'Email should have been sent successfully');

        // Optionally, you can assert more details about the message here if needed
    }
}

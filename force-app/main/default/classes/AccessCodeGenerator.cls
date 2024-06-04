public class AccessCodeGenerator {
    // Method to generate a random access code
    public static String generateAccessCode() {
        String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String code = '';
        Integer length = 10;
        for (Integer i = 0; i < length; i++) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            code += chars.sPubstring(idx, idx + 1);
        }
        return code;
    }

    // Method to send an email with the access code
    public static void sendAccessCodeEmail(String email, String accessCode) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {email});
        mail.setSubject('Your Access Code');
        mail.setPlainTextBody('Congratulations! Here is your access code: ' + accessCode + '\nPlease use this as your temporary password to log in and reset your password.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    // Method to create a portal user with the access code as the temporary password
    public static void createPortalUser(Contact con, String accessCode) {
        User newUser = new User();
        newUser.Username = con.Email;
        newUser.Email = con.Email;
        newUser.LastName = con.LastName != null ? con.LastName : 'Customer';
        newUser.Alias = con.Email.substring(0, 5);
        newUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].Id;
        newUser.TimeZoneSidKey = 'GMT';
        newUser.LocaleSidKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.CommunityNickname = con.Email.substring(0, con.Email.indexOf('@'));
        newUser.ContactId = con.Id;
        insert newUser;
        
        // Set the access code as the temporary password
        System.setPassword(newUser.Id, accessCode);
    }
}

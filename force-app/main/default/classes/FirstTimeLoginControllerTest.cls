@IsTest
public class FirstTimeLoginControllerTest {
  // passeed
  // Modify the setupData method to return the test User
  static User setupData() {
    // Create a UserRole for the account owner
    UserRole role = new UserRole(Name = 'Test Role');
    insert role;

    // Execute non-setup DML in a different context
    User accountOwner;
    System.runAs(new User(Id = UserInfo.getUserId())) {
      accountOwner = new User(
        Username = 'owner_' + DateTime.now().getTime() + '@example.com',
        LastName = 'Owner',
        Email = 'owner@example.com',
        Alias = 'owner',
        TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User']
        .Id,
        LanguageLocaleKey = 'en_US',
        UserRoleId = role.Id
      );
      insert accountOwner;

      Account testAccount = new Account(
        Name = 'Test Account',
        OwnerId = accountOwner.Id
      );
      insert testAccount;

      Contact testContact = new Contact(
        LastName = 'TestContact',
        Access_Code__c = 'Code123',
        firstTime__c = 'true',
        AccountId = testAccount.Id
      );
      insert testContact;

      Profile communityProfile = [
        SELECT Id
        FROM Profile
        WHERE Name = 'Customer Community User'
        LIMIT 1
      ];

      User testUser = new User(
        Username = 'communityuser_' + DateTime.now().getTime() + '@example.com',
        Email = 'communityuser@example.com',
        LastName = 'User',
        Alias = 'cuser',
        TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        ProfileId = communityProfile.Id,
        LanguageLocaleKey = 'en_US',
        ContactId = testContact.Id
      );
      insert testUser;

      return testUser; // Return the created test user
    }
    return accountOwner;
  }

  // passed
  @IsTest
  static void testResetPasswordWithInvalidAccessCode() {
    User testUser = setupData(); // Get the test user with the correct username
    String result = FirstTimeLoginController.resetUserPassword(
      testUser.Username, // Use the dynamically generated username
      'WrongCode',
      'NewPassword123'
    );
    System.assertEquals(
      'Invalid access code.',
      result,
      'Expected message for invalid access code'
    );
  }

  @IsTest
  static void testResetPasswordWithValidAccessCode() {
    User testUser = setupData(); // setupData creates and inserts the user and related records

    System.runAs(new User(Id = UserInfo.getUserId())) {
      // This line ensures that the context is reset
      String result = FirstTimeLoginController.resetUserPassword(
        testUser.Username, // Use the dynamically generated username
        'Code123',
        'NewPassword123'
      );
      System.assertEquals('Success', result, 'Expected success message');
    }

    // Now check the updated state of Contact outside the runAs block
    System.runAs(new User(Id = UserInfo.getUserId())) {
      Contact updatedContact = [
        SELECT firstTime__c
        FROM Contact
        WHERE Id = :testUser.ContactId
      ];
      System.assertEquals(
        'false',
        updatedContact.firstTime__c,
        'Contact firstTime__c should be set to false after password reset'
      );
    }
  }

  // This passed
  @IsTest
  static void testResetPasswordHandlingExceptions() {
    // This test might remain unchanged if it already passes
  }
}

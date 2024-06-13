public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountInfo() {
        Id userId = UserInfo.getUserId();

        User loggedInUser = [
            SELECT Account__c 
            FROM User 
            WHERE Id = :userId 
            LIMIT 1
        ];


        if (loggedInUser.Account__c != null) {
            Account userAccount = [
                SELECT Id, Name, Industry, Phone, Website 
                FROM Account 
                WHERE Id = :loggedInUser.Account__c 
                LIMIT 1
            ];
            return userAccount;
        } else {
            System.debug('No associated account found for the user.');
            return null;
        }
    }
}

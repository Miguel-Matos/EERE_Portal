public with sharing class ApplicationController {
    public ApplicationController() {

    }

    @AuraEnabled(cacheable=true)
    public static Application__c getApplicationInfo() {
        Id userId = UserInfo.getUserId();

        User loggedInUser = [
            SELECT Application__c 
            FROM User 
            WHERE Id = :userId 
            LIMIT 1
        ];


        if (loggedInUser.Application__c != null) {
            Application__c userApp = [
                SELECT Id, Name, Stage__c, Phone__c, Company__c 
                FROM Application__c 
                WHERE Id = :loggedInUser.Application__c
                LIMIT 1
            ];
            return userApp;
        } else {
            System.debug('No associated application found for the user.');
            return null;
        }
    }
}
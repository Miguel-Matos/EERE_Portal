public with sharing class ContactController {
    @AuraEnabled
    public static void createContact(Contact con) {
        try {
            insert con;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
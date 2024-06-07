public with sharing class InquiryController {
    @AuraEnabled
    public static void createInquiry(Inquiry__c inq) {
        try {
            insert inq;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
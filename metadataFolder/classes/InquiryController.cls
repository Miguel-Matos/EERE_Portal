public with sharing class InquiryController {
    @AuraEnabled
    public static void createInquiry(Inquiry__c inq) {
        if (inq == null) {
            throw new AuraHandledException('Inquiry object is null.');
        }

        try {
            insert inq;
        } catch (DmlException e) {
            // Log the error for debugging purposes
            System.debug('Error inserting Inquiry: ' + e.getMessage());
            throw new AuraHandledException('An error occurred while creating the inquiry. Please try again later.');
        } catch (Exception e) {
            // Catch any other exceptions
            System.debug('General error: ' + e.getMessage());
            throw new AuraHandledException('An unexpected error occurred. Please contact support.');
        }
    }
}

trigger LeadTrigger on Lead (after update) {
    for (Lead lead : Trigger.new) {
        if (lead.IsConverted && !Trigger.oldMap.get(lead.Id).IsConverted) {
            // Generate Access Code
            String accessCode = AccessCodeGenerator.generateAccessCode();
            
            // Get the converted Account and Contact
            Account acc = [SELECT Id FROM Account WHERE Id = :lead.ConvertedAccountId LIMIT 1];
            Contact con = [SELECT Id, Email, LastName FROM Contact WHERE Id = :lead.ConvertedContactId LIMIT 1];
            
            // Set the Access Code on the Account
            acc.Access_Code__c = accessCode;
            update acc;

            if (con != null) {
                AccessCodeGenerator.sendAccessCodeEmail(con.Email, accessCode);
            }
        }
    }
}

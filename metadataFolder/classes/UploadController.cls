public with sharing class UploadController {
    public UploadController() {}

    @AuraEnabled(cacheable=false)
    public static void uploadFile(String fileName, String contentVersionId) {
        // Get the user ID of the person logged in
        Id userId = UserInfo.getUserId();
        
        // Get the username of the currently logged in user to name the folder later on
        User currentUser = [SELECT Id, Username FROM User WHERE Id = :userId LIMIT 1];
        String folderName = currentUser.Username;

        // Name and insert the folder
        ContentFolder folder;
        List<ContentFolder> folders = [SELECT Id, Name FROM ContentFolder WHERE Name = :folderName LIMIT 1];
        if (folders.isEmpty()) {
            folder = new ContentFolder(Name = folderName, ParentContentFolderId = null);
            insert folder;
        } else {
            folder = folders[0];
        }

        // Inserts the file into the folder
        ContentVersion contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionId LIMIT 1];
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = contentVersion.ContentDocumentId,
            LinkedEntityId = folder.Id,
            ShareType = 'I' // Inference share type
        );
        insert cdl;
    }
}

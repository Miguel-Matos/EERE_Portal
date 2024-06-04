public with sharing class LoginController {
    @AuraEnabled
    public static AuthResponse authenticateUser(String username, String password) {
        AuthResponse response = new AuthResponse();
        try {
            User u = [SELECT Id, Username FROM User WHERE Username = :username LIMIT 1];
            if (u != null) {
                // Perform password check (this is a simplified example, use a secure method in production)
                if (password == 'Thebestteam1') { // Replace this with actual password verification
                    response.success = true;
                } else {
                    response.success = false;
                    response.errorMessage = 'Invalid password';
                }
            } else {
                response.success = false;
                response.errorMessage = 'User not found';
            }
        } catch (Exception e) {
            response.success = false;
            response.errorMessage = 'An error occurred during authentication';
        }
        return response;
    }

    public class AuthResponse {
        @AuraEnabled
        public Boolean success;
        @AuraEnabled
        public String errorMessage;
    }
}
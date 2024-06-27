# frozen_string_literal: true

# AuthenticationService
#
# This class is responsible for authenticating users.
# It uses the User model to find a user by email
# and checks if the password matches the stored password.
# If the authentication is successful, it returns the user object.
# If the authentication fails, it returns nil.
#
# Usage:
#
#   AuthenticationService.authenticate('user@example.com', 'password123')
#
class AuthenticationService
  # Authenticates a user by email and password.
  #
  # @param email [String] the user's email
  # @param password [String] the user's password
  # @return [User, nil] the authenticated user object or nil if authentication fails
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return user if user && user.password == password
    nil
  end
end


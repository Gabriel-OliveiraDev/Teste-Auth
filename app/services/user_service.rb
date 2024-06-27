# frozen_string_literal: true

# UserService
#
# This class is responsible for handling user related operations.
# It has two methods:
# - create_user: Creates a new user with the given email and password.
#   It returns a hash with success and user keys.
#   If the user creation is successful, success is true and user contains the created user.
#   If the user creation fails, success is false and errors contains the validation errors.
# - check_email: Checks if a user with the given email exists.
#   It returns a hash with exist key.
#   If a user with the given email exists, exist is true.
#   Otherwise, exist is false.
#
class UserService
  # Creates a new user with the given email and password.
  #
  # @param email [String] The email of the user.
  # @param password [String] The password of the user.
  # @return [Hash] A hash with success and user keys.
  def self.create_user(email, password)
    user = User.new(email: email)
    user.password = password
    if user.save
      { success: true, user: user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  # Checks if a user with the given email exists.
  #
  # @param email [String] The email of the user.
  # @return [Hash] A hash with exist key.
  def self.check_email(email)
    { exist: User.find_by(email: email) }
  end
end

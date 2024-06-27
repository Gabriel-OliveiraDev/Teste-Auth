# frozen_string_literal: true

# User model
#
# This class represents a user in the application.
# It includes BCrypt for password hashing and validation.
#
# Attributes:
#   - email (String): The email address of the user.
#
# Validations:
#   - email: presence and uniqueness
#
# Methods:
#   - password: returns a Password object initialized with the password_hash attribute
#   - password=: sets the password attribute and updates the password_hash attribute
class User < ActiveRecord::Base
  include BCrypt

  validates :email, presence: true, uniqueness: true

  # Returns a Password object initialized with the password_hash attribute
  #
  # @return [Password] a Password object
  def password
    @password ||= Password.new(password_hash)
  end

  # Sets the password attribute and updates the password_hash attribute
  #
  # @param new_password [String] the new password
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end


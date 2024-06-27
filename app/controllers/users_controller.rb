# frozen_string_literal: true

# UsersController
#
# This controller handles user registration
class UsersController < ApplicationController
  # Creates a new user with the given email and password.
  # If the user creation is successful, it returns a success message.
  # If the user creation fails, it returns an error message.
  #
  # @param [String] email The email of the user.
  # @param [String] password The password of the user.
  #
  # @return [JSON] A JSON object with a success message or an error message.
  post '/register' do
    if UserService.check_email(params['email'])[:exist]
      status 409
      { error: 'email already in use' }.to_json
    else
      result = UserService.create_user(params['email'], params['password'])
      result[:success] ? {message: "User Created: #{result[:user].email}"}.to_json : {error: result[:errors]}.to_json
    end
  end
end


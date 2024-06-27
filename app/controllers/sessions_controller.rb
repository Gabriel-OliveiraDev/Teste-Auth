# frozen_string_literal: true

# SessionController
#
# This controller handles user authentication and session management.
# It has three routes:
# - POST '/login': Authenticates the user and returns the user's email.
# - POST '/logout': Logs out the user and returns a success message.
# - POST '/unauthenticated': Returns an error message if the user is not authenticated.
class SessionsController < ApplicationController
  # Authenticates the user and returns the user's email.
  #
  # @return [String] The user's email.
  # @example
  #   POST '/login'
  #   {
  #     "message": "Login: user@example.com"
  #   }
  post '/login' do
    env['warden'].authenticate!
    { message: "Login: #{current_user.email}" }.to_json
  end

  # Logs out the user and returns a success message.
  #
  # @return [String] A success message.
  # @example
  #   POST '/logout'
  #   {
  #     "message": "Logged out"
  #   }
  post '/logout' do
    env['warden'].logout
    { message: 'Logged out' }.to_json
  end

  # Returns an error message if the user is not authenticated.
  #
  # @return [String] An error message.
  # @example
  #   POST '/unauthenticated'
  #   {
  #     "error": "Login failed"
  #   }
  post '/unauthenticated' do
    status 401
    { error: 'Login failed' }.to_json
  end
end


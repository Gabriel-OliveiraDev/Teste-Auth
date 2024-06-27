# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'warden'
require 'bcrypt'
require 'json'
require 'require_all'

require_all 'app/'
require_all 'lib/'

# Configure ActiveRecord
set :database_file, 'database.yml'

# Configure Warden
#
# Warden is a Ruby gem for authentication middleware.
# It provides a simple way to authenticate requests.
# The Warden middleware is used to protect routes that require authentication.
# If a request is not authenticated, it returns a 401 Unauthorized response.
use Warden::Manager do |config|
  config.default_strategies :password

  # Configure the failure app
  #
  # The failure app determines what to do when a request is not authenticated.
  # In this case, it returns a 401 Unauthorized response with a JSON body.
  config.failure_app = lambda do |_env|
    ['401', { 'Content-Type' => 'application/json' }, [[{ error: 'Unauthorized' }].to_json]]
  end
end

# Configure the password strategy for Warden
#
# This strategy is used to authenticate requests with email and password parameters.
# It calls the AuthenticationService.authenticate method to perform the authentication.
# If the authentication is successful, it sets the user as the authenticated user.
# If the authentication fails, it raises an exception.
Warden::Strategies.add(:password) do
  # Check if the request has email and password parameters
  def valid?
    params['email'] && params['password']
  end

  # Authenticate the request
  #
  # This method calls the AuthenticationService.authenticate method to authenticate the request.
  # If the authentication is successful, it sets the authenticated user.
  # If the authentication fails, it raises an exception.
  def authenticate!
    user = AuthenticationService.authenticate(params['email'], params['password'])
    user.nil? ? raise('Invalid credentials') : success!(user)
  end
end

# Configure the Rack JSON body parser middleware
#
# The Rack JSON body parser middleware parses the request body as JSON.
# It sets the parsed JSON as the 'rack.request.form_hash' parameter.
use Rack::JSONBodyParser

# Include the controllers

use ApplicationController
use SessionsController
use UsersController

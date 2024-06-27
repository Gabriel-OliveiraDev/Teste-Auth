# frozen_string_literal: true

# ApplicationController is the base class for all controllers in the application.
# It sets up the content type to JSON and provides helper methods for authentication.
#
# Instance Methods:
#   current_user: Returns the currently authenticated user.
#   authenticated?: Checks if the user is authenticated.
#
class ApplicationController < Sinatra::Base
  enable :sessions

  before do
    content_type :json
  end

  helpers do
    # Returns the currently authenticated user.
    #
    # @return [User] The authenticated user or nil if not authenticated.
    def current_user
      env['warden'].user
    end

    # Checks if the user is authenticated.
    #
    # @return [Boolean] True if the user is authenticated, false otherwise.
    def authenticated?
      !current_user.nil?
    end
  end
end

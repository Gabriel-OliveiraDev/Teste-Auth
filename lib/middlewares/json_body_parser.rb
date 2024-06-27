# frozen_string_literal: true

# JSONBodyParser is a middleware that parses the request body as JSON.
# It sets the parsed JSON as the 'rack.request.form_hash' parameter.
#
# Example usage:
#
#   use Rack::JSONBodyParser
#
# This middleware is used to parse JSON request bodies.
# It should be used in conjunction with the Rack::Request middleware.
#
# The middleware checks if the content type of the request is 'application/json'.
# If it is, the middleware parses the request body as JSON and
# sets the parsed JSON as the 'rack.request.form_hash' parameter.
#
# The 'rack.request.form_hash' parameter is used by the Rack::Request middleware
# to return the parsed JSON as the request parameters.
#
# Note: This middleware should be used before the Rack::Request middleware.
#
module Rack
  class JSONBodyParser
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['CONTENT_TYPE'] =~ %r{^application/json}
        request = Rack::Request.new(env)
        env.update('rack.request.form_hash' => JSON.parse(request.body.read))
      end
      @app.call(env)
    end
  end
end


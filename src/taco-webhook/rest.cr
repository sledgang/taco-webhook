require "http/client"
require "openssl/ssl/context"

module Taco
  # REST Wrapper for Trello webhook operations
  module REST
    API_URL = "https://api.trello.com/1/tokens"

    def request(method, resource = "", params : String? = "")
      response = HTTP::Client.exec(
        method,
        "#{API_URL}/#{token}/webhooks#{resource}?key=#{key}&#{params}"
      )

      response.body
    end

    # Creates a new webhook.
    def post(model, callback_url, description = nil)
      params = HTTP::Params.build do |form|
        form.add("idModel", model)
        form.add("callbackURL", callback_url)
        if description
          form.add("description", description)
        end
      end

      request(
        "POST",
        params: params
      )
    end

    # Gets all webhooks on this token
    def get
      request("GET")
    end

    # Deletes a webhook.
    def delete(id)
      request(
        "DELETE",
        "/#{id}"
      )
    end
  end
end

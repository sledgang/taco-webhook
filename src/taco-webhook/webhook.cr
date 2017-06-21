require "json"

module Taco
  class Client
    include REST

    getter token : String

    getter key : String

    def initialize(@token, @key)
    end

    def create_webhook(model, callback_url, description = nil)
      Webhook.new(
        self,
        post(model, callback_url, description)
      )
    end

    def webhooks
      objects = [] of Webhook

      parser = JSON::PullParser.new(get)
      parser.read_array do
        objects << Webhook.new(self, parser.read_raw)
      end

      objects
    end
  end

  class Webhook
    include REST

    @client : Client?

    def token
      @client.not_nil!.token
    end

    def key
      @client.not_nil!.key
    end
    
    JSON.mapping(
     id: String,
     callback_url: {key: "callbackURL", type: String},
     model: {key: "idModel", type: String},
     description: String?,
     active: Bool
    )

    def initialize(client, json)
      initialize(JSON::PullParser.new(json))
      @client = client
    end

    def delete
      delete(@id)
    end
  end
end

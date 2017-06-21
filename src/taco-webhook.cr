require "./taco-webhook/*"

client = Taco::Client.new("TOKEN", "KEY")

p client.webhooks

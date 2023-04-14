OpenAI.configure do |config|
  config.access_token = ENV["CHAT_GPT"]
  config.request_timeout = 240
end

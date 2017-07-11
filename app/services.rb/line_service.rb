require 'line/bot'
class LineService
  def initialize

  end

  def self.send(user_id, text)
    message = {
      type: 'text',
      text: text
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = Setting.line_channel_secret
        config.channel_token = Setting.line_channel_access_token
    }
    response = client.push_message(user_id, message)
    p response
  end
end
require 'twilio-ruby'

class Messaging

  def initialize
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @phone_number = ENV["PHONE_NUMBER"]
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_text
    @client.messages.create(
      to: @phone_number,
      from: +17627602250,
      body: "Thank you! Your order was placed and will be delivered before #{one_hour_from_now}"
    )
  end

  def one_hour_from_now
    time = Time.now + 1*60*60
    "#{time.hour}:#{time.min}"
  end

  

end
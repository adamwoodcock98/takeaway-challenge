require './lib/messaging.rb'

class Takeaway

  attr_accessor :total, :order, :messaging

  def initialize(order = Order.new, messaging = Messaging.new)
    @order = order
    @messaging = messaging
    print_twilio_warning
  end

  def check_order_price(price)
    update_total
    price == @total
  end

  def complete_order
    update_total
    @messaging.send_text
  end

  private

  def update_total
    @total = @order.finalise
  end

  def print_twilio_warning
    puts "----------------"
    puts "CAUTION: Before proceeding"
    puts "If you would like to send SMS messages, please ensure you have entered your credentials as environment variables"
    puts "----------------"
  end

end
require 'AfricasTalkingGateway'

module SmsSender
  include ActionView::Helpers::NumberHelper
  extend self

  def send_transaction_receipt_notification!(transfer)
    @transfer = transfer
    puts username
    puts api_key
    gateway = AfricasTalkingGateway.new(username, api_key)

    begin
      reports = gateway.sendMessage(transfer.to_account.phone, message)

      reports.each {|x|
        puts 'number=' + x.number + ';status=' + x.status + ';statusCode=' + x.status + ';messageId=' + x.messageId + ';cost=' + x.cost
      }
    rescue AfricasTalkingGatewayException => ex
      puts 'SmsSender Encountered an error: ' + ex.message
    end
  end

  def message
    "You received #{number_to_currency(@transfer.amount.to_d)} from #{@transfer.from_account.phone} on #{@transfer.created_at.to_formatted_s(:long_ordinal)}."
  end

  def username
    Rails.application.secrets.username
  end

  def api_key
    Rails.application.secrets.api_key
  end
end
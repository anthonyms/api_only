class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: :Account
  belongs_to :to_account, class_name: :Account

  validates :amount, numericality: { greater_than: 0 }

  after_create_commit :send_notification, :send_email_confirmation

  def as_json(options = nil)
    { from: from_account.user.phone,
      to: to_account.user.phone,
      amount: amount,
      date: created_at.to_formatted_s(:long)
    }
  end

  private

  def send_notification
    SmsSender.send_transaction_receipt_notification!(self)
  end

  def send_email_confirmation
    ApplicationMailer.send_transaction_receipt_notification(self).deliver!
  end
end

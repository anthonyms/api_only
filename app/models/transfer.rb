class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: :Account
  belongs_to :to_account, class_name: :Account

  validates :amount, numericality: { greater_than: 0 }

  after_create :send_notification, :send_email_confirmation

  def as_json(options = nil)
    { from: from_account.user.phone,
      to: to_account.user.phone,
      amount: amount,
      date: created_at.to_formatted_s(:long)
    }
  end

  private

  def send_notification

  end

  def send_email_confirmation

  end
end

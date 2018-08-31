class Account < ApplicationRecord
  belongs_to :user

  #TODO rename to external account
  scope :system_account, -> {find_by(user: User.system_user)}
  delegate :phone, :email, to: :user

  def transfers
    Transfer.where("to_account_id = ? OR from_account_id = ?", self.id, self.id)
  end

  #TODO convert to 1 db hit
  def balance
    Transfer.where('to_account_id = ?', self.id).sum(:amount) - Transfer.where('from_account_id = ?', self.id).sum(:amount)
  end
end

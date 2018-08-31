class User < ApplicationRecord
  has_secure_password
  has_one :account

  validates_presence_of :phone, :email, :password_digest
  validates_uniqueness_of :email
  validates_uniqueness_of :phone

  after_create_commit :create_account

  scope :system_user, -> {find_by(phone: '+254000000000')}

  private
  def create_account
    Account.create!(user: self)
  end
end

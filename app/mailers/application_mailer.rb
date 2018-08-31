class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  default from: 'quiop9554@gmail.com'

  def send_transaction_receipt_notification(transfer)
    @transfer = transfer
    mail(to: transfer.to_account.email, subject: 'You have been paid')
  end
end

class Api::V1::AccountsController < ApplicationController

  def top_up
    validate_request

    if @errors.blank?
      transfer = Transfer.new(from_account: system_account, to_account: account, amount: account_params[:amount])

      if transfer.save!
        render json: { success: 'Top-up performed succesfully' }, status: 201
      else
        render json: { error: transfer.errors }, status: 400
      end
    else
      render json: { error: @errors }, status: 400
    end
  end

  #Should be index
  def report
    validate_request
    transfers = account&.transfers
    if transfers
      render json: { transfers: transfers }, status: 201
      ApplicationMailer.transaction_report(account, transfers).deliver!
    else
      render json: { error: 'Unable to display transfers' }, status: 400
    end
  end

  def account_params
    params.permit(:account, :amount, :start_time, :end_time)
  end

  private

  def validate_request
    @errors = []
    raise "Recipient account not found" unless account
  rescue => ex
    @errors << ex.message
  end

  def account
    User.find_by(phone: account_params[:account])&.account
  end

  def system_account
    Account.system_account
  end
end

class Api::V1::TransfersController < ApplicationController

  def transfer
    validate_request

    if @errors.blank?
      transfer = Transfer.new(from_account: from_account, to_account: to_account, amount: transfer_params[:amount])

      if transfer.save!
        render json: { success: 'Transfer succesfully initiated' }, status: 201
      else
        render json: { error: transfer.errors }, status: 400
      end
    else
      render json: { error: @errors }, status: 400
    end
  end

  private

  def validate_request
    @errors = []
    raise "Sender account not found" unless from_account
    raise "Recipient account not found" unless to_account
    raise "Authenticated user is not authorised to transfer from the sender account" unless @user.account == from_account
    raise "Insufficeint funds in sender account" unless from_account.balance >= BigDecimal(transfer_params[:amount])
    raise "Cannot transfer to same account" if from_account == to_account
  rescue => ex
    @errors << ex.message
  end

  def from_account
    User.find_by(phone: transfer_params[:from])&.account
  end

  def to_account
    User.find_by(phone: transfer_params[:to])&.account
  end

  def transfer_params
    params.permit(:from, :to, :amount)
  end

end

class ApplicationController < ActionController::API
  before_action :authenticate_user

  @errors = {}

  #Get token from header, check user exists, check token is for user

  def authenticate_user
    return unless authorize
    @user
  end

  def authorize
    unless authorization_header.present?
      render json: { error: 'Missing Token' }, status: 401 and return
    end
    unless valid_token
      render json: { error: 'Invalid Token' }, status: 401 and return
    end
    unless user_exists
      render json: { error: 'Invalid User Token' }, status: 401 and return
    end
    @user
  end

  def valid_token
    JwtService.decode(authentication_token)
  rescue JWT::ExpiredSignature
    errors[:token] = "Expired Token"
    nil
  rescue JWT::DecodeError
    errors[:token] = "Invalid Token"
    nil
  rescue => ex
    errors[:token] = "Invalid Token2"
    nil
  end

  def authentication_token
    authorization_header.split(':').last
  end

  def authorization_header
    request.headers['Authorization']
  end

  def user_exists
    @user ||= User.find_by(email: decoded_email)
  end

  def decoded_email
    JwtService.decode(authentication_token)['user_email']
  end

  def errors
    @errors ||= {}
  end
end

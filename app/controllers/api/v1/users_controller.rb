class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:register, :login]

  def register
    @user = User.create(user_params)
    if @user.save
      render json: { message: 'User created successfully'}, status: 201
    else
      render json: @user.errors, status: 400
    end
  end

  def login
    user = User.find_by_email(user_params[:email])
    if user&.authenticate(user_params[:password])
      token = JwtService.encode(contents(user))
      render json: { authentication_token: token}, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: 401
    end
  end

  def show
    render json: { message: 'Show rendered successfully'}, status: 200
  end

  private

  def user_params
    params.permit(:phone, :email, :password)
  end

  def contents(user)
    {
      user_email: user.email,
      expiry: 24.hours.from_now.to_i
    }
  end
end

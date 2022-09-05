class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64(7)
      user.last_name = "ゲスト"
      user.first_name = "ユーザー"
      user.user_classification_id = 1
      user.zipcode = "1234567"
      user.prefecture = "埼玉県"
      user.municipality = "春日部市"
      user.address = "1-23-4"
      user.phone_number = "0120333444"
    end
    log_in(user)
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
end

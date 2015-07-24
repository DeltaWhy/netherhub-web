class ApiController < ApplicationController
  skip_before_action :authenticate_user!

  def authenticate
    @user = User.find_by_email(params[:email])
    if @user and @user.valid_password?(params[:password])
      exp = Time.now.to_i + 24*3600
      payload = {user: @user.id, exp: exp}
      token = JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
      render text: token
    else
      render text: "Invalid credentials.", status: 403
    end
  end
end

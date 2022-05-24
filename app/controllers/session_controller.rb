# frozen_string_literal: true

# this class is for log user in
class SessionController < ApplicationController
  skip_before_action :rooted
  before_action :session?, except: %i[destroy]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = 'Invalid email or password'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end

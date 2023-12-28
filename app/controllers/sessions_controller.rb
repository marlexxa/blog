class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to root_path
      flash[:notice] = "Welcome back #{user.name}!"   
    else
      redirect_to log_in_path
      flash[:notice] = 'E-mail and/or password is incorrect.' 
    end
  end

  def destroy
    session.delete(:current_user_id)
    logout_user_name = current_user.name
    @_current_user = nil
    redirect_to root_path
    flash[:notice] = "Goodbye #{logout_user_name}. See you soon!"
  end
end

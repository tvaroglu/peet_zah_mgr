class SessionsController < ApplicationController
  def new
    redirect_to pizzas_path and return if current_user
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to pizzas_path, notice: "Welcome to Peet Zah Mgr!"
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Take care.. and don't forget to wash your hands!"
  end
end

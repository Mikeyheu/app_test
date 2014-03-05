class SessionsController < ApplicationController 
  def new
  end

  def create
  	user = User.find_by(email: params[:email]).try(:authenticate, params[:password])  
  	
  	if user
  		session[:user_id] = user.id
  		redirect_to user_path(user), notice: "Logged in"
  	else
  		flash.now.alert = 'Invalid email or password'
  		render :new
  	end
  end

  private

end
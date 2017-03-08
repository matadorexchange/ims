class SessionsController < ApplicationController
  def new

  end

  def create
	#user = User.new
	#user.first_name = 'P'
	#user.last_name = 'G'
	#user.login = 'pg'
	#user.password = 'test123'
	#user.password_confirmation = 'test123'
	#user.share_holding = 20.0
	#user.save
     user = User.find_by(login: params[:session][:login].downcase)
     #puts "hellosjhksdjshd === " + user.inspect
     if user && user.authenticate(params[:session][:password])
	log_in user
	redirect_to :controller => 'pages', :action => 'home'
     else
	flash[:danger] = 'Invalid email/password combination'
	render 'new'
     end	

  end

  def destroy 
	log_out
	redirect_to :controller => 'pages', :action => 'home'
  end
end

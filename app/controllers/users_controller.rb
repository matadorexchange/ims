class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      			redirect_to :controller => 'pages', :action => 'home'
    		else
      			render 'new'
    		end
	end

	def edit
		@user = User.find_by(id: session[:user_id])
	end

	def update
		@user = User.find_by(id: session[:user_id])
		if @user.update_attributes(user_pp_params)
                        redirect_to :controller=>'sessions', :action => 'destroy'
                else
                        render 'edit'
                end
	end
   private
        def user_params
                params.require(:user).permit(:first_name, :last_name, :login, :share_holding, :password, :password_confirmation)
        end
	
	def user_pp_params
                params.fetch(:user, {}).permit(:password, :password_confirmation)
        end
end

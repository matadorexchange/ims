class PagesController < ApplicationController
	def home
		if !logged_in
			redirect_to :controller =>'sessions', :action =>'new'
		end
	end

	def members
	
	end
end

class MembersController < ApplicationController

  def index
 	@members = Member.order('login').paginate(:page => params[:page], :per_page => 10)
  	@rates = Rate.all
	@users = User.all
  end
  
  def new
	@member = Member.new
	@rate = Rate.new
	@mss = MemberStatus.new
  	index
  end

  def show
	#@members = Members.all
	#puts " hello " 
	#puts @members.inspect 
  end

  def create
  	@member = Member.new(member_params)
	@rate = Rate.new(rate_params)
	@mss = MemberStatus.new(mss_params)
	#puts @member.inspect
	if @member.save
		mm = Member.where("login=?",@member.login)
		if (mm.size == 1)
			mm.each do |m|
				#puts @rate.inspect
				@rate.member_id = m.id
				@mss.member_id = m.id
			end	
		else
			puts "error creating rates"
		end
		@rate.save
		@mss.save
		redirect_to :back
	else
		render 'new'
	end
  end
 
  private
  	def member_params
		params.require(:member).permit(:first_name, :last_name, :sevens_id, :login, :source, :master_agent_id)
	end

	def rate_params
		params.fetch(:rate, {}).permit(:rate, :currency)
	end

	def mss_params
		params.fetch(:member_status,{}).permit(:status)
	end
end

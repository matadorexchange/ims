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
	@eMember = Member.find_by_login(params[:login])
	@eMss = MemberStatus.find_by_member_id(@eMember.id)
	@eRate = Rate.find_by_member_id(@eMember.id)
	@eMasterAgent = MasterAgent.find(@eMember.master_agent_id)
  
  end

  def update
	#@members = Members.all
	#puts " hello " 
	#puts @members.inspect
	@eMem = Member.find(params[:id])
	if @eMem.update_attributes(member_params)
		@eRa = Rate.find_by_member_id(@eMem.id)
        	@eMs = MemberStatus.find_by_member_id(@eMem.id)
		@eRa.update_attributes(rate_params)
		@eMs.update_attributes(mss_params)
		flash[:success] = "Profile updated"
		redirect_to :back
	end
 
  end

  def create
  	@member = Member.new(member_params)
	@rate = Rate.new(rate_params)
	@mss = MemberStatus.new(mss_params)
	@pts = PositionTaking.new
	#puts @member.inspect
	if @member.save
		mm = Member.where("login=?",@member.login)
		if (mm.size == 1)
			mm.each do |m|
				#puts @rate.inspect
				@rate.member_id = m.id
				@mss.member_id = m.id
				
				# create default position taking
				# saving for cricket
				@pts.member_id = m.id
				@pts.market_id = 1
				@pts.position = 40
				@pts.save
				@pts = PositionTaking.new
				#saving for football
				@pts.member_id = m.id
                                @pts.market_id = 2
                                @pts.position = 40
                                @pts.save
				@pts = PositionTaking.new
				#saving for tennis
				@pts.member_id = m.id
                                @pts.market_id = 3
                                @pts.position = 40
                                @pts.save
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

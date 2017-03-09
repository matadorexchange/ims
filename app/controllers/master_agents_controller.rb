class MasterAgentsController < ApplicationController

  def new
        @masterAgent = MasterAgent.new
  	@masterAgents = MasterAgent.all
  end

  def create
        @masterAgent = MasterAgent.new(master_agent_params)
        #puts @member.inspect
        if @masterAgent.save
                redirect_to :back
        else
                render 'new'
        end
  end

  private
        def master_agent_params
                params.require(:master_agent).permit(:name, :commission, :login)
        end
end

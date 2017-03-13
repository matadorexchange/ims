class SettlementSummariesController < ApplicationController
  def new
  end

  def index
  	@settlement_summaries = SettlementSummary.paginate(:page => params[:page], :per_page => 10)
  end
end

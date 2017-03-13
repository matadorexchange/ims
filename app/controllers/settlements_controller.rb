class SettlementsController < ApplicationController
  def new

  end

  def index
  end

  def show
  	settlements = Settlement.where(week_id: params[:week])
	@sMap = Hash.new
	@weekID = params[:week]
	singleS = Settlement.find_by_week_id(params[:week])
	@fromDate = singleS.from_date
	@endDate = singleS.end_date
	settlements.each do |s|
		agentId = MasterAgent.find(Member.find(s.member_id).master_agent_id)
		sArray = @sMap[agentId.id]
		if !sArray
			sArray = Array.new
		end
		sArray.push(s)
		@sMap[agentId.id] = sArray	
	end
  end

  def import
  	importData(params[:file])
  	redirect_to :controler => "settlement_summaries", :action => "index"
  end

  def importData(file)
  	spreadsheet = open_spreadsheet(file)
  	header = spreadsheet.row(1)

	#fields for settlement summary
	ssWeekId = 0
	ssValue = 0
	ssDownline = 0
	ssUpline = 0
	ssAgentCommission = 0
	ssProfitLoss = 0

	agentCommMap = Hash.new

  	(2..spreadsheet.last_row).each do |i|
    		row = Hash[[header, spreadsheet.row(i)].transpose]
		settleObj = Settlement.new
	
		#Creating object for Settlement	
		mem_id = Member.find_by_login(row["member_id"]).id
		settleObj.member_id = mem_id
		settleObj.source = row["source"]	
		settleObj.week_id = row["week_id"]
		settleObj.from_date = row["from_date"]
		settleObj.end_date = row["end_date"]
		sCoins = 0
		
		#if member on sevens only then we have coins, else it is only value
		if(row["source"] == "sevens")
			sCoins = row["coins"]
		end
		settleObj.coins = sCoins

		sVal = 0
		to_currency = "INR"
		if(row["source"] == "sevens")
			rateObj = Rate.find_by_member_id(mem_id)
			rateToCal = rateObj.rate
			sCurrency = rateObj.currency
 			sVal = sCoins * rateToCal
			if (sCurrency == "AED")
				sVal = sCoins * rateToCal * 18.9
			end
		else
			sVal = row["value"]
		end
		settleObj.value = sVal
		settleObj.currency = to_currency
		settleObj.save

		#calculations for Settlement Summary
		ssWeekId = row["week_id"]
		ssValue = ssValue + sVal
		ssDownline = ssDownline + sCoins
		if(row["source"] == "upline")
			ssUpline = sVal
		end

		#calculate agent commission
                agent_id = Member.find_by_login(row["member_id"]).master_agent_id
                agentSubCommMap = agentCommMap[agent_id]
                if !agentSubCommMap
                        agentSubCommMap = Hash.new
                        agentSubCommMap["total_coins"] = 0
                        agentSubCommMap["total_val"] = 0
                end             
                agentCoins = agentSubCommMap["total_coins"]
		agentCoins = agentCoins + sCoins
		agentTotalValue = agentSubCommMap["total_val"]
		agentTotalValue = agentTotalValue + sVal 
		
		agentSubCommMap["total_coins"] = agentCoins
		agentSubCommMap["total_val"] = agentTotalValue
		agentCommMap[agent_id] = agentSubCommMap
  	end
	
	#Agent Comission Object
	agentCommMap.each do |agentID, agentValueDetails|
		agentCommObj = AgentCommission.new
		agentCommObj.week_id = ssWeekId
		agentCommObj.master_agent_id = agentID
		agentCommObj.coins = agentValueDetails["total_coins"]
		agentCommObj.value = agentValueDetails["total_val"]
		commissionVal = 0
		if (agentValueDetails["total_val"] < 0)
			commissionVal = ((MasterAgent.find(agentID).commission)*agentValueDetails["total_val"]*(-1))/100
		end
		ssAgentCommission = ssAgentCommission + commissionVal
		agentCommObj.commission_val = commissionVal
		agentCommObj.save
	end

	#SettlementSummaryObject
	settlementSummaryObj = SettlementSummary.new
	settlementSummaryObj.week_id = ssWeekId
	settlementSummaryObj.value = ssValue*(-1)
	settlementSummaryObj.downline = ssDownline*(-1)
	settlementSummaryObj.upline = ssUpline
	settlementSummaryObj.agent_commission = ssAgentCommission
	profit_loss = ssValue*(-1) + ssUpline - ssAgentCommission
	settlementSummaryObj.profit_loss = profit_loss
	settlementSummaryObj.currency = "INR"
	settlementSummaryObj.save


	#UserSettlementSummary Obj
	User.all.each do |u|
		ussObj = UserSettlementSummary.new
		ussObj.week_id = ssWeekId
		ussObj.user_id = u.id
		ussObj.value = (profit_loss*u.share_holding)/100
		ussObj.save
	end		
  end

  def open_spreadsheet(file)
  	case File.extname(file.original_filename)
  	when ".csv" then Roo::Csv.new(file.path, :ignore)
  	when ".xls" then Roo::Excel.new(file.path, options={})
  	when ".xlsx" then Roo::Excelx.new(file.path, :ignore)
  	else raise "Unknown file type: #{file.original_filename}"
  	end
  end
end

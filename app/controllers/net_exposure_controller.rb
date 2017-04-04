require 'watir'

class NetExposureController < ApplicationController
  def new
  end

  def index
	browser = Watir::Browser.new

	browser.goto('http://backoffice.place')
	browser.input(id: 'username').send_keys('ss1.7486')
	browser.input(id: 'password').send_keys('nutty31sjs07')
	browser.button(id: 'submit').click
	browser.link(:text => "Risk Management").click
	browser.link(:text => "Net Exposure").click
	myLinks = Array.new
	mySubLinks = Array.new
	sleep 3
	browser.divs(:class => "apl-table-overflow").each do |d|
   		d.links.each {|link|
        		if link.href.include? "net-exposure-breakdown"
                		myLinks << link.href
        		end
   		}	
	end  
	# now you have a list of all the games -- now go into each match and get the links
	matches = Array.new
	map = Hash.new
	id = 0
	myLinks.each do |l|
        	browser.goto(l)
        	sleep 2
        	matches = browser.links.collect(&:href)
        	matches.each {|m|
                	if m and m.to_s.include? "net-exposure-breakdown" and !m.to_s.include? "bet-breakdown"
                        	mySubLinks << m.to_s
                	end
        	}
        	map[id] = mySubLinks
        	mySubLinks = Array.new
        	id = id + 1
	end
	
	# now go into each master agent and get the data
	netExposureBreakDown = Hash.new
	map.each do |key, matchLinks|
        	String matchTitle = ""
        	netBreakDownByAgents = Array.new
        	matchLinks.each do |ml|
                	browser.goto(ml)
                	sleep 2
                        matchTitle = browser.td(:class, "cell-event-title ng-binding").text
                	tableData = browser.table(:class, "apl-table apl-table-striped apl-table-hover table-M last").text
                	netBreakDownByAgents << tableData
                	netExposureBreakDown[matchTitle] = netBreakDownByAgents
        	end
        	matchTitle = ""
	end
	puts "Net Exposure\n"
	puts netExposureBreakDown.inspect
	@dataToPrint = Hash.new
	@dataToPrintByUser = Hash.new
	netExposureBreakDown.each do |matchTitle, dataArray|
		byMatchData = Array.new
		puts "Match title == " + matchTitle.to_s
		dataArray.each do |dataLine|
			dt = dataLine.split("\n")
			puts dt.inspect
			dt.each do |ab|
				properData = ab.split(' ')
				userData = Array.new
				userData [0] = properData[0]
				teamOneC = properData[2].gsub(',','').to_i
				userData[1] = teamOneC
			
				userRate = 0
				currency_rate = 1
				puts properData[0]
				if properData[0].include? "rlx" or properData[0].include? "dadaji" or properData[0].include? "gaurav"
					userRate = 125 - 60
				else
					member = Member.find_by_login(properData[0])
					uRate = Rate.find_by_member_id(member.id)
					currency_rate = 1
					if (uRate.currency == "AED")
						currency_rate = 18.5
					end
					userRate = (uRate.rate)*currency_rate - 60
				end
				userData[2] = teamOneC*userRate*(-1)
				teamDC = properData[3].gsub(',','').to_i
				userData[3] = teamDC
				userData[4] = '-'
				if (properData[3] != '-')
					userData[4] = teamDC*userRate*(-1)
				end
				teamTwoC = properData[4].gsub(',','').to_i
				userData[5] = teamTwoC
				userData[6] = teamTwoC*userRate*(-1)
				puts userData.inspect
				byMatchData << userData
				
				summarizedUserNetExposure = @dataToPrintByUser[properData[0]]
				if !summarizedUserNetExposure
					summarizedUserNetExposure = Array.new
					summarizedUserNetExposure[0] = 0
					summarizedUserNetExposure[1] = 0
					summarizedUserNetExposure[2] = 0
					summarizedUserNetExposure[3] = 0
				end
				userCoinsData = Array.new
				userValueData = Array.new
				userCoinsData << userData[1]
				if !userData[3] == '-'
					userCoinsData << userData[3]
				else
					userCoinsData << 0
				end
				userCoinsData << userData[5]
			
				maxCoinLoss = userCoinsData.min
				maxCoinWin = userCoinsData.max
				if maxCoinLoss
					summarizedUserNetExposure[0] = summarizedUserNetExposure[0] + maxCoinLoss
					summarizedUserNetExposure[1] = summarizedUserNetExposure[1] + maxCoinLoss*userRate*(-1)
				end
				if maxCoinWin
					summarizedUserNetExposure[2] = summarizedUserNetExposure[2] + maxCoinWin
                                	summarizedUserNetExposure[3] = summarizedUserNetExposure[3] + maxCoinWin*userRate*(-1)
				end
				@dataToPrintByUser[properData[0]] = summarizedUserNetExposure	
				
			end
		end
		@dataToPrint[matchTitle] = byMatchData
	end
	puts @dataToPrintByUser.inspect
	browser.close
  end

end

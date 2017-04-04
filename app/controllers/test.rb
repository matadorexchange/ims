require 'watir'

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
	puts "hello" 
	if link.href.include? "net-exposure-breakdown"
		myLinks << link.href
	end 
   }
end

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
netExposureBreakDown = Hash.new
map.each do |key, matchLinks|
	String matchTitle = ""
	netBreakDownByAgents = Array.new
	matchLinks.each do |ml|
		browser.goto(ml)
		sleep 2
		if !matchTitle.to_s.empty?
			matchTitle = browser.td(:class, "cell-event-title ng-binding").text
		end
		#puts browser.html
	       	tableData = browser.table(:class, "apl-table apl-table-striped apl-table-hover table-M last").text
		netBreakDownByAgents << tableData
		exit
		netExposureBreakDown[matchTitle] = netBreakDownByAgents
	end
	matchTitle = ""
end
#puts browser.html
browser.close

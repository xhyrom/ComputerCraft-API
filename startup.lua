os.loadAPI("/API/error.lua")
os.loadAPI("/API/api.lua")
api.terminate()




--Functions

function Clear()
    term.clear()
    term.setCursorPos(1,1)
end
 
function CP(x,y)
    term.setCursorPos(x,y)
end
 
function BC(color)
    term.setBackgroundColor(color)
end
 
function TC(color)
    term.setTextColor(color)
end


function InstallClear(anzeige)
	
	BC(1)
	Clear()

	w, h = term.getSize()

	wC = 0
	hC = 1
	
	while true do

		wC = (wC+1)
	
		CP(wC, hC)
		BC(SystemColor)
		write(" ")
	
		if wC == w then
			if hC == 3 then
				break
			else
				hC = (hC+1)
				wC = 0
			end
		end
	
	end
	
	TC(1)
	CP(((w/2)-((#anzeige)/2)),2)

	print(anzeige)
	
end

-- Animation
 
BC(32768)
Clear()
sleep(0.1)
BC(128)
Clear()
sleep(0.1)
BC(256)
Clear()
sleep(0.1)
BC(1)
Clear()
sleep(0.1)

--Variables

SystemColor = 16


-- CraftOS or API

w, h = term.getSize()

InstallClear(" CraftOS or API")

BC(SystemColor)
TC(1)

CP(10,10)
print("           ")
CP(10,11)
print("    API    ")
CP(10,12)
print("           ")

CP((w-20),10)
print("           ")
CP((w-20),11)
print("  CraftOS  ")
CP((w-20),12)
print("           ")

while true do

	event, side, x, y = os.pullEvent()
	if event == "mouse_click" then
		
		
		if x >= 10 and x <= 20 and y >= 10 and y <= 12 then
			start = "API"
			break
			
		end
		
		if x >= (w-20) and x <= (w-10) and y >= 10 and y <= 12 then
			start = "CraftOS"
			break
			
		end
		
	end
	
end

-- API OR CRAFTOS SELECT

if start == "API" then
	term.setBackgroundColor(colors.black)
	term.clear()
	api.setPos(1,1)

	function main()
    		api.randomcolor()
    		api.send("Loading API...")
    		api.line()
    
    		api.sleep(2)
    		shell.run("cd /.sys")		
	
    		api.clear()
    		api.randomcolor()
    
    		api.setPos(1,1)
    
    		api.newsend("API loaded!","info")
    		api.line()
	end

	error.doErrorTrap(main)
elseif start == "CraftOS" then
	os.unloadAPI("/API/error.lua")
	os.unloadAPI("/API/api.lua")
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
    shell.run("cd /.craftos")
	shell.run("shell")
	os.unloadAPI("/API/error.lua")
	os.unloadAPI("/API/api.lua")
end
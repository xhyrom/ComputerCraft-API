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

local function get( sUrl )
    local ok, err = http.checkURL( sUrl )
    if not ok then
        print("ERROR Failed")
        if err then
            print("ERROR Failed")
        end
        return nil
    end

    local response = http.get( sUrl , nil , true )
    if not response then
        print("ERROR Failed")
	return nil
    end

    local sResponse = response.readAll()
    response.close()
    return sResponse
end

function specialsend(text,settings)
  if settings == "log" then
    term.setTextColor(colors.gray)
    write("[")
    term.setTextColor(colors.blue)
    write("LOG")
    term.setTextColor(colors.gray)
    write("]")
    term.setTextColor(colors.white)
    print(" "..text)
    sleep(0.1)
  end
  if settings == "err" then
    term.setTextColor(colors.gray)
    write("[")
    term.setTextColor(colors.red)
    write("ERROR")
    term.setTextColor(colors.gray)
    write("]")
    term.setTextColor(colors.white)
    print(" "..text)
    sleep(0.1)
  end
end

function download(url,file)
local sUrl = url
local sFile = file
local sPath = shell.resolve( sFile )
if fs.exists( sPath ) then
    specialsend("File already exists","err")
    return
end

-- Do the get
local res = get( sUrl )
if res then
    local file = fs.open( sPath, "wb" )
    file.write( res )
    file.close()

    specialsend("Downloaded "..sFile.."","log")
    
end
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
 
 
-- FIRST INSTALL YES OR NO
 
w, h = term.getSize()
 
InstallClear(" Install Setup")
 
BC(SystemColor)
TC(1)
 
CP(10,10)
print("           ")
CP(10,11)
print("  Install  ")
CP(10,12)
print("           ")
 
CP((w-20),10)
print("           ")
CP((w-20),11)
print("    Exit   ")
CP((w-20),12)
print("           ")
 
while true do
 
    event, side, x, y = os.pullEvent()
    if event == "mouse_click" then
       
       
        if x >= 10 and x <= 20 and y >= 10 and y <= 12 then
            install = "yes"
            break
           
        end
       
        if x >= (w-20) and x <= (w-10) and y >= 10 and y <= 12 then
            install = "exit"
            break
           
        end
       
    end
   
end
 
-- SECOND INSTALL LOGS
 
InstallClear(" Install Logs")
 
function InstallLogs()
    if install == "yes" then
   
   term.setCursorPos(1,5)
   term.setBackgroundColor(colors.black)
   fs.delete("API")
   fs.delete("example.lua")
   fs.delete("startup.lua")
   fs.makeDir("API")
   fs.makeDir(".sys")
   fs.makeDir(".craftos")
   os.setComputerLabel("Text_API")
   shell.run("cd /API")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/API/api.lua","api.lua")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/API/error.lua","error.lua")
   shell.run("cd /.sys")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/.sys/example.lua","example.lua")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/.sys/ipconfig.lua","ipconfig.lua")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/.sys/error.lua","error.lua")
   shell.run("cd /")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/startup.lua","startup.lua")
 
   os.loadAPI("/API/error.lua")
   os.loadAPI("/API/api.lua")
 
   api.newsend("Succesfully instaled!","log")
   api.sleep(0.4)
   api.newsend("Website: https://hyrousek.tk","info")
   api.sleep(0.4)
   api.newsend("By tntj#6356 and Hyro#8938","custom","DEVELOPER",colors.yellow)
   api.sleep(0.4)
   api.newsend("API version: 1.0","custom","VERSION",colors.orange)
   api.sleep(0.4)
   api.newsend("For update use: pastebin run CDd1uXv6","info")
   api.sleep(0.4)
   api.newsend("Starting API...","warn")
   api.sleep(2)
   os.reboot()
   
    elseif install == "exit" then
 
   term.setCursorPos(1,5)
   term.setBackgroundColor(colors.black)
   fs.makeDir("API")
   shell.run("cd /API")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/API/api.lua","api.lua")
   download("https://raw.githubusercontent.com/xHyroM/ComputerCraft-API/master/API/error.lua","error.lua")
 
   os.loadAPI("/API/error.lua")
   os.loadAPI("/API/api.lua")
 
   api.newsend("Creating temp file!","info")
   api.sleep(0.5)
   api.newsend("Installation closed!","error")
   api.sleep(0.4)
   api.newsend("Not found API version","error")
   api.sleep(0.4)
   api.newsend("Repair computer...","warn")
   api.sleep(0.2)
   api.newsend("Please dont off computer!","custom","SYSTEM",colors.orange)
   api.sleep(2)
   api.newsend("Computer repaired!","custom","SUCCESS",colors.green)
   api.sleep(0.4)
   api.newsend("Temp file deleted!","info")
   api.sleep(0.4)
   api.newsend("Restarting computer!","log")
   fs.delete("API")
   fs.delete(".sys")
   fs.delete(".craftos")
   fs.delete("startup.lua")
   api.sleep(1)
   os.reboot()
   return
 
    end
end
 
InstallLogs()

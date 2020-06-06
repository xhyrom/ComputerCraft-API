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

-- SEND | WRITE

function specialsend(text,settings,customprefix,customcolor)
  if settings == "info" then
  	term.setTextColor(colors.gray)
  	write("[")
  	term.setTextColor(colors.green)
  	write("INFO")
  	term.setTextColor(colors.gray)
  	write("]")
  	term.setTextColor(colors.white)
  	print(" "..text)
  	sleep(0.1)
  end
  if settings == "warn" then
  	term.setTextColor(colors.gray)
 	write("[")
  	term.setTextColor(colors.orange)
  	write("WARN")
  	term.setTextColor(colors.gray)
 	write("]")
 	term.setTextColor(colors.white)
  	print(" "..text)
  	sleep(0.1)
  end
  if settings == "error" or settings == "err" then
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
  if settings == "success" then
    term.setTextColor(colors.gray)
    write("[")
    term.setTextColor(colors.green)
    write("SUCCESS")
    term.setTextColor(colors.gray)
    write("]")
    term.setTextColor(colors.white)
    print(" "..text)
    sleep(0.1)
  end
  if settings == "custom" then
 	term.setTextColor(colors.gray)
 	write("[")
 	term.setTextColor(customcolor)
 	write(customprefix)
  	term.setTextColor(colors.gray)
 	write("]")
  	term.setTextColor(colors.white)
        print(" "..text)
  	sleep(0.1)
  end

  if settings == none then
	print(text)
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
 
InstallClear(" Uninstall API")
 
BC(SystemColor)
TC(1)
 
CP(10,10)
print("           ")
CP(10,11)
print(" Uninstall ")
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
 
-- SECOND UNINSTALL LOGS
 
InstallClear(" Uninstall Logs")
 
function UnInstallLogs()
    if install == "yes" then
   
   term.setCursorPos(1,5)
   term.setBackgroundColor(colors.black)
   fs.delete("/API")
   fs.delete("/.sys")
   fs.delete("/.craftos")
   fs.delete("/startup.lua")
 
   specialsend("Succesfully uninstaled!","log")
   os.sleep(0.4)
   specialsend("Website: https://hyrousek.tk","info")
   os.sleep(0.4)
   specialsend("By tntj#6356 and Hyro#8938","custom","DEVELOPER",colors.yellow)
   os.sleep(0.4)
   specialsend("For install use: pastebin run CDd1uXv6","info")
   os.sleep(0.4)
   specialsend("Disable API...","warn")
   os.sleep(0.4)
   os.reboot()
   
    elseif install == "exit" then
 
   term.setCursorPos(1,5)
   term.setBackgroundColor(colors.black)

   specialsend("Creating temp file!","info")
   os.sleep(0.5)
   specialsend("Uninstallation closed!","error")
   os.sleep(0.4)
   specialsend("Please dont off computer!","custom","SYSTEM",colors.orange)
   os.sleep(2)
   specialsend("Temp file deleted!","info")
   os.sleep(0.4)
   specialsend("Restarting computer!","log")
   os.sleep(1)
   os.reboot()
   return
 
    end
end
 
UnInstallLogs()

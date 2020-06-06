os.loadAPI("/API/error.lua")
os.loadAPI("/API/api.lua")

function main()

    -- SETUP
    api.clear()
    api.color(colors.blue)
    api.setPos(1,1)

    -- CONTROL OS
    if os.version() ~= "CraftOS 1.8" then
    	api.newsend("This version CraftOS is not supported!", "warn")
    	api.newsend("Please use CraftOS 1.8 or "..os.version().." and update API", "warn")
    	sleep(0.1)
     end

   -- NORMAL SEND
   api.send("[NORMAL SEND] send")
   api.line()
   
   -- NEW SEND
   
   ---- SET NEW SEND ----
   -- INFO/WARN/ERROR/LOG: api2.newsend("text","info/warn/error/err/log")
   -- ONLY TEXT: api2.newsend("text")
   -- CUSTOM: api2.newsend("text","custom","PREFIX",colors.red/colors.blue/colors.green/colors.orange) 

   api.newsend("info","info")
   api.newsend("warn","warn")
   api.newsend("error","error")
   api.newsend("err","err")
   api.newsend("log","log")
   api.newsend("normal")
   
   -- CUSTOM NEW SEND
   api.newsend("custom message","custom","HYRO",colors.red)

   -- RANDOM NUMBER
   api.mrandom(1, 90)
   
   -- DECODE / ENCODE
   api.encode("ahoj")
   api.decode("YWhvag==")
end

error.doErrorTrap(main)
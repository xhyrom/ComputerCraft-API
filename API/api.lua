function terminate()
	os.pullEvent = os.pullEventRaw
end

function setPos(x,y) 
	term.setCursorPos(x,y) 
end

-- LOGIN SYSTEM
function login(username,password)
os.pullEvent = os.pullEventRaw

clear()

access = "false"

color(colors.white)
write("Please login you user!\n")
color(colors.gray)
write("----------------------\n")
color(colors.white)
write("Username: ")
color(colors.red)
local user = read()
color(colors.white)
write("Password: ")
color(colors.red)
local pass = read("*")
color(colors.gray)
write("----------------------\n")


if user == username and pass == password then
	access = "true"
end

if access == "true" then
	color(colors.orange)
	print("Logging in...")
	sleep(2)
	term.clear()
	color(colors.gray)
	write("----------------------\n")
	color(colors.green)
   	print("   Success password")
	color(colors.gray)
	write("----------------------\n")
	sleep(1)
	color(colors.white)
	print("Welcome "..user.."\n")
	color(colors.yellow)
	sleep(2)
else
	term.clear()
	color(colors.gray)
	write("-------------------------------\n")
	color(colors.red)
	print("Invalid username or password.")
	color(colors.gray)
	write("-------------------------------\n")
	sleep(1)
	os.reboot()
end
end


-- DECODE OR ENCODE

-- MAIN FUNCTIONS FOR DECODE / ENCODE
function lsh(value,shift)
	return (value*(2^shift)) % 256
end
function rsh(value,shift)
	return math.floor(value/2^shift) % 256
end
function bit(x,b)
	return (x % 2^b - x % 2^(b-1) > 0)
end
function lor(x,y)
	result = 0
	for p=1,8 do result = result + (((bit(x,p) or bit(y,p)) == true) and 2^(p-1) or 0) end
	return result
end

-- Encoding
local base64chars = {[0]='A',[1]='B',[2]='C',[3]='D',[4]='E',[5]='F',[6]='G',[7]='H',[8]='I',[9]='J',[10]='K',[11]='L',[12]='M',[13]='N',[14]='O',[15]='P',[16]='Q',[17]='R',[18]='S',[19]='T',[20]='U',[21]='V',[22]='W',[23]='X',[24]='Y',[25]='Z',[26]='a',[27]='b',[28]='c',[29]='d',[30]='e',[31]='f',[32]='g',[33]='h',[34]='i',[35]='j',[36]='k',[37]='l',[38]='m',[39]='n',[40]='o',[41]='p',[42]='q',[43]='r',[44]='s',[45]='t',[46]='u',[47]='v',[48]='w',[49]='x',[50]='y',[51]='z',[52]='0',[53]='1',[54]='2',[55]='3',[56]='4',[57]='5',[58]='6',[59]='7',[60]='8',[61]='9',[62]='-',[63]='_'}
function xyopaasd(data)
	local bytes = {}
	local result = ""
	for spos=0,string.len(data)-1,3 do
		for byte=1,3 do bytes[byte] = string.byte(string.sub(data,(spos+byte))) or 0 end
		result = string.format('%s%s%s%s%s',result,base64chars[rsh(bytes[1],2)],base64chars[lor(lsh((bytes[1] % 4),4), rsh(bytes[2],4))] or "=",((#data-spos) > 1) and base64chars[lor(lsh(bytes[2] % 16,2), rsh(bytes[3],6))] or "=",((#data-spos) > 2) and base64chars[(bytes[3] % 64)] or "=")
	end
	return result
end

-- Decoding
local base64bytes = {['A']=0,['B']=1,['C']=2,['D']=3,['E']=4,['F']=5,['G']=6,['H']=7,['I']=8,['J']=9,['K']=10,['L']=11,['M']=12,['N']=13,['O']=14,['P']=15,['Q']=16,['R']=17,['S']=18,['T']=19,['U']=20,['V']=21,['W']=22,['X']=23,['Y']=24,['Z']=25,['a']=26,['b']=27,['c']=28,['d']=29,['e']=30,['f']=31,['g']=32,['h']=33,['i']=34,['j']=35,['k']=36,['l']=37,['m']=38,['n']=39,['o']=40,['p']=41,['q']=42,['r']=43,['s']=44,['t']=45,['u']=46,['v']=47,['w']=48,['x']=49,['y']=50,['z']=51,['0']=52,['1']=53,['2']=54,['3']=55,['4']=56,['5']=57,['6']=58,['7']=59,['8']=60,['9']=61,['-']=62,['_']=63,['=']=nil}
function xYxyxcyxvc(data)
	local chars = {}
	local result=""
	for dpos=0,string.len(data)-1,4 do
		for char=1,4 do chars[char] = base64bytes[(string.sub(data,(dpos+char),(dpos+char)) or "=")] end
		result = string.format('%s%s%s%s',result,string.char(lor(lsh(chars[1],2), rsh(chars[2],4))),(chars[3] ~= nil) and string.char(lor(lsh(chars[2],4), rsh(chars[3],2))) or "",(chars[4] ~= nil) and string.char(lor(lsh(chars[3],6) % 192, (chars[4]))) or "")
	end
	return result
end

-- Encoding
function encode(text)

EorD = "-e"
ForS = "-s"
tBE = text

if tBE == null then
	newsend("Please write text","error")
	return
end

if EorD == "-E" or EorD == "-e" then
	if ForS == "-S" or ForS == "-s" then
		color(colors.yellow)
		encoded = xyopaasd(tBE)
		newsend("Original: "..text.." | Encoded: "..encoded.."","info")
	else
		return
	end
end

end

-- Decoding
function decode(text)

EorD = "-e"
ForS = "-s"
tBE = text

if tBE == null then
	newsend("Please write text","error")
	return
end

if EorD == "-E" or EorD == "-e" then
	if ForS == "-S" or ForS == "-s" then
		color(colors.yellow)
		decoded = xYxyxcyxvc(tBE)
		newsend("Original: "..text.." | Decoded: "..decoded.."","info")
	else
		return
	end
end

end

-- MATH FUNCTIONS

function mrandom(small,big)
    if small == null then
	newsend("Please write first number","err")
	return
    end
    if big == null then
	newsend("Please write second number","err")
	return
    end
    if small >= big then
	newsend("Please write valid first number","err")
	return
    end
	
	print(math.random(small, big))
end

-- LOGIN API
function loginapi(pass)

	local hwidone = os.getComputerLabel()
	local hwidtwo = os.getComputerID() / 3 * 96 - 54
	local hwidspecial = os.getComputerID() / 34 * 965 - 541

	local secret = hwidone.."-"..hwidtwo.."-apisecurity"..hwidspecial

	if pass == secret then
		newsend("Success Logined! ","info")
	else
		newsend("Login failed! API Secret not found","err")
	end
end

-- IP CONFIFG
function ipconfig()
	local ipone = os.getComputerID() * 14 + 4 - 19
	local iptwo = os.getComputerID() / 2 * 90 - 514
	local ipthree = 65 * 2 + os.getComputerID() + 31

	local iponesix = os.getComputerID() * 14 + 987 - 19
	local iptwosix = os.getComputerLabel()
	local iptwosixadd = os.getComputerID() * 89 + 81
	local ipthreesix = 654 * 2 + os.getComputerID() + 31489
        local ipthreesixadd = os.getComputerLabel()
	local ipnumbers = os.getComputerID() * 849 + 332 - 982

	local hwidone = os.getComputerLabel()
	local hwidtwo = os.getComputerID() / 3 * 96 - 54
	local hwidspecial = os.getComputerID() / 34 * 965 - 541

	color(colors.gray)
	textutils.slowPrint("--- IP CONFIG ---")
        color(colors.white)
	write("ID: ")
        color(colors.orange)
        write(os.getComputerID().."\n")
	color(colors.white)
	write("Label: ")
        color(colors.orange)
        write(os.getComputerLabel().."\n")
	color(colors.white)
	write("IPv4: ")
        color(colors.orange)
        write(ipone.."."..iptwo.."."..ipthree.."\n")
	color(colors.white)
	write("IPv6: ")
        color(colors.orange)
        write(iponesix..":"..iptwosix..""..iptwosixadd.."."..ipthreesix..""..ipthreesixadd..":"..ipnumbers.."\n")
	color(colors.white)
	write("API Secret: ")
        color(colors.orange)
        write(hwidone.."-"..hwidtwo.."-apisecurity"..hwidspecial.."\n")
end

-- SET API

function setLabel(text)
   if text == null then
		term.setBackgroundColor(colors.blue)
		term.clear()
		term.setCursorPos(24,2)
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.blue)
		print("BSOD")
		term.setCursorPos(4,4)
		term.setBackgroundColor(colors.blue)
		term.setTextColor(colors.white)
		print("An error has occurred. To continue:")
		term.setCursorPos(4,6)
		print("Press Enter to return to CraftOS, or")
		term.setCursorPos(4,8)
		print("Press CTRL+R to restart your computer.")
		term.setCursorPos(4,9)
		print("If you do this, you will lose any unsaved")
		term.setCursorPos(4,10)
		print("information in all open applications.")
		term.setCursorPos(4,12)
		print("Error: ")
		term.setCursorPos(4,13)
		print("Unespected string |text|")
		term.setCursorPos(12,16)
		write("Press any key to continue ")
	    while true do
            local event = {os.pullEvent()}
            if event[1] == "key" then
		os.reboot()
                break
            end
         end
   else
	os.setComputerLabel(text)
 	newsend("Label set!","info")
    end
end

-- GET API

function getID()
	print(os.getComputerID())
end

function getId()
	print(os.getComputerID())
end

function getLabel()
   if os.getComputerLabel() == null then
	newsend("Label not set!", "warn")
   else
	print(os.getComputerLabel())
   end
end

function getLABEL()
   if os.getComputerLabel() == null then
	newsend("Label not set!", "warn")
   else
	print(os.getComputerLabel())
   end
end

-- LINE

function line()
	write("\n")
end

-- COLORS

function color(text)
        term.setTextColor(text)
end

function randomcolor()
if term.isColour() then
    term.setTextColour( 2^math.random(1,15) )
end
end

-- CLEAR

function clear()
        term.clear()
	setPos(1,1)
end

-- SLEEP

function sleep(number)
	os.sleep(number)
end

-- SEND | WRITE

function newsend(text,settings,customprefix,customcolor)
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

function send(text)
        write(text)
end
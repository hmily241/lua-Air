module(...,package.seeall)

--[[
��������
����LCD��Ļ����ʾ����
]]

local LCD_UART_ID = 2
local currentPage = 0
local pageLock = false
local testDot = false

function getCurrentPage()
	return currentPage
end

--֡ͷ�����Լ�֡β
local CMD_SCANNER,CMD_GPIO,CMD_PORT,FRM_TAIL = 1,2,3,string.char(0xC0)
--���ڶ��������ݻ�����
local rdbuf = ""
local debug = false
--[[
��������print
����  ����ӡ�ӿڣ����ļ��е����д�ӡ�������testǰ׺
����  ����
����ֵ����
]]
local function print(...)
	if(debug) then _G.print("[LCD]",...) end
end

--[[
��������read
����  ����ȡ���ڽ��յ�������
����  ����
����ֵ����
]]
local function read()

end

--[[
��������write
����  ��ͨ�����ڷ�������
����  ��
		s��Ҫ���͵�����
����ֵ����
]]
function write(s)
	print("write",s)
	uart.write(LCD_UART_ID,s..string.char(255)..string.char(255)..string.char(255))
end

function setPage(id)
	if(pageLock == false)then
		write("page "..id)
		currentPage = id
	end
end

function lockPage(state)
	pageLock = state
end

function setInfo(cnt)
	write("info.txt=\""..cnt.."\"")
end

function displayTestDot()
	if(testDot == false) then
		setInfo(".")
		testDot = true
	else
		setInfo("")
		testDot = false
	end
end

function setText(textName,txt)
     write(textName..".txt=\""..txt.."\"")
end

function setNumber(numName,num)
     write(numName..".val="..num)
end

function setPic(numName,num)
     write(numName..".pic="..num)
end



function drawRec(startPos,endPos,size,bFill)
     startPosX = 45--37
     startPosY = 41--33
     if(bFill==0) then
     write("fill "..startPos*size+startPosX..","..endPos*size+startPosY..","..size..","..size..",WHITE"..string.char(255)..string.char(255)..string.char(255))
     end
end

function qrCodeDisp(qrCode,qrLength)
	lockPage(true)
	setPage(2)
	write("fill 33,29,170,170,BLACK"..string.char(255)..string.char(255)..string.char(255))
	local h2b = {
	    ["0"] = 0,
	    ["1"] = 1,
	    ["2"] = 2,
	    ["3"] = 3,
	    ["4"] = 4,
	    ["5"] = 5,
	    ["6"] = 6,
	    ["7"] = 7,
	    ["8"] = 8,
	    ["9"] = 9,
	    ["A"] = 10,
	    ["B"] = 11,
	    ["C"] = 12,
	    ["D"] = 13,
	    ["E"] = 14,
	    ["F"] = 15
	}
	print(string.len(qrCode))
	if(qrLength == 841)then
		row = 29
	end
	count = 1
	currentRow = 0
	currentCol = 0
	for currentBlock = 1,string.len(qrCode),1 do
		currentChar = string.sub(qrCode,currentBlock,currentBlock)
		--print(currentBlock,currentChar,h2b[string.upper(currentChar)])
		--output = ""
		currentNum = h2b[string.upper(currentChar)]
		bitMask = 8
		repeat
			--bit.band(currentNum,bitMask)/bitMask is what we needed
			--output = output .. bit.band(currentNum,bitMask)/bitMask
			currentColor = bit.band(currentNum,bitMask)/bitMask
			drawRec(currentCol,currentRow,5,currentColor)
			count = count + 1
			currentRow = currentRow + 1
			if(currentRow == row) then
				currentRow = 0
				currentCol = currentCol + 1
			end
			bitMask = bitMask/2
			if(count > qrLength) then
				break
			end
		until bitMask < 1
		--print(output)
	end
end


--����ϵͳ���ڻ���״̬���˴�ֻ��Ϊ�˲�����Ҫ�����Դ�ģ��û�еط�����pm.sleep("test")���ߣ��������͹�������״̬
--�ڿ�����Ҫ�󹦺ĵ͡�����Ŀʱ��һ��Ҫ��취��֤pm.wake("test")���ڲ���Ҫ����ʱ����pm.sleep("test")
--pm.wake("test")
--ע�ᴮ�ڵ����ݽ��պ����������յ����ݺ󣬻����жϷ�ʽ������read�ӿڶ�ȡ����
sys.reguart(LCD_UART_ID,read)
--���ò��Ҵ򿪴���

uart.setup(LCD_UART_ID,9600,8,uart.PAR_NONE,uart.STOP_1)

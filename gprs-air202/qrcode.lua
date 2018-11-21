--[[
ģ�����ƣ���ά�����ɲ���ʾ����Ļ��
ģ������޸�ʱ�䣺2017.11.10
]]

module(...,package.seeall)

--LCD�ֱ��ʵĿ�Ⱥ͸߶�(��λ������)
WIDTH,HEIGHT = disp.getlcdinfo()

--- qrencode.encode(string) ������ά����Ϣ
-- @param string ��ά���ַ���
-- @return width ���ɵĶ�ά����Ϣ���
-- @return data ���ɵĶ�ά������
-- @usage local width, data = qrencode.encode("http://www.openluat.com")
--nvm.get("qrCodeUrl")

--nvm.get("qrCodeUrl"))

--- disp.putqrcode(data, width, display_width, x, y) ��ʾ��ά��
-- @param data ��qrencode.encode���صĶ�ά������
-- @param width ��ά�����ݵ�ʵ�ʿ��
-- @param display_width ��ά��ʵ����ʾ���
-- @param x ��ά����ʾ��ʼ����x
-- @param y ��ά����ʾ��ʼ����y

--- ��ά����ʾ����
local function appQRCode()
	local width, data = qrencode.encode(nvm.get("qrCodeUrl"))
	disp.clear()
	disp.drawrect(0, 0, WIDTH-1, HEIGHT-1, WHITE)
	local displayWidth = (WIDTH>HEIGHT and HEIGHT or WIDTH)-4
	disp.putqrcode(data, width, displayWidth, (WIDTH-displayWidth)/2, (HEIGHT-displayWidth)/2)
	disp.update()
end

--pins.setup(pio.P0_10,1)
appQRCode()
--pins.setup(pio.P0_10,0)

module(...,package.seeall)
require"lbsloc"

--�Ƿ��ѯGPSλ���ַ�����Ϣ
local qryaddr
local locLat = nil
local locLng = nil

--[[
��������print
����  ����ӡ�ӿڣ����ļ��е����д�ӡ�������testǰ׺
����  ����
����ֵ����
]]
local function print(...)
	_G.print("locator",...)
end

--[[
��������qrygps
����  ����ѯGPSλ������
����  ����
����ֵ����
]]
local function qrygps()
	qryaddr = not qryaddr
	lbsloc.request(getgps,qryaddr)
end

function getLocation()
	sys.timer_start(qrygps,20000)
	return locLat,locLng
end

--[[
��������getgps
����  ����ȡ��γ�Ⱥ�Ļص�����
����  ��
		result��number���ͣ���ȡ�����0��ʾ�ɹ��������ʾʧ�ܡ��˽��Ϊ0ʱ�����5��������������
		lat��string���ͣ�γ�ȣ���������3λ��С������7λ������031.2425864
		lng��string���ͣ����ȣ���������3λ��С������7λ������121.4736522
		addr��string���ͣ�GB2312�����λ���ַ���������lbsloc.request��ѯ��γ�ȣ�����ĵڶ�������Ϊtrueʱ���ŷ��ر�����
		latdm��string���ͣ�γ�ȣ��ȷָ�ʽ����������5λ��С������6λ��dddmm.mmmmmm������03114.555184
		lngdm��string���ͣ�γ�ȣ��ȷָ�ʽ����������5λ��С������6λ��dddmm.mmmmmm������12128.419132
����ֵ����
]]
function getgps(result,lat,lng,addr,latdm,lngdm)
	print("getgps",result,lat,lng,addr,latdm,lngdm)
	--��ȡ��γ�ȳɹ�
	if result==0 then
	locLat = lat
	locLng = lng
	sys.timer_stop(qrygps)
	return
	--ʧ��
	else
	end
	sys.timer_start(qrygps,20000)
end

--20���ȥ��ѯ��γ�ȣ���ѯ���ͨ���ص�����getgps����
sys.timer_start(qrygps,20000)

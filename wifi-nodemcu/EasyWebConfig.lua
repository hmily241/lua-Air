--------------------------------------------------------------------------------
-- EasyWebConfig module for NODEMCU
-- LICENCE: http://opensource.org/licenses/MIT
-- yangbo<gyangbo@gmail.com>
--------------------------------------------------------------------------------

--[[
here is the demo.lua:
require("EasyWebConfig")
--EasyWebConfig.addVar("gateWay")
--EasyWebConfig.addVar("userKey")
EasyWebConfig.doMyFile("demo.lua")
--]]
local moduleName = "EasyWebConfig"
local M = {}
_G[moduleName] = M
_G["wifiStatue"] = "..."

_G["config"]  = {}

local userScriptFile = ""


function M.doMyFile(fName)
     userScriptFile = fName
end

function M.addVar(vName)
     if(_G["config"].vName == nil) then
          table.insert(_G["config"],{name=vName,value=""})
     end
end

--M.addVar("ssid")
--M.addVar("password")
require("network_default_cfg")
print ("LoadDefault")

M.addVar("ssid")
M.addVar("password")

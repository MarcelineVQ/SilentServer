-- Name: SilentServer

local system_patterns = {
  '^Delete your WDB',
  '^If you want',
  '^Keep up to',
  '^We encourage everyone',
  '^All gold transactions',
  '^Tune in to',
  '^Follow us on',
  '^If you enjoy',
  '^/join world to',
  '^Welcome to Turtle',
  '^Six years of',
  '^Download the anniversary',
  '^Adventurers, travelers and',
  'Radio',
  'Everlook',
  'Broadcasting',
  'Vrograg',
  'Tavern Talk',
  'Sheal',
  'Easter',
  'sale',
  'tokens',
  'Check out our new home',
  ".- %[%d+-%d+%] started!", -- battleground
}

local ignore_npc = {
  ["Fizzle \"The Sharpened Scissors\""] = true, -- barber
  ["Pierre \"Le Coiffeur\" Dufresne"] = true, -- barber
  ["Tansy Sparkpen"] = true, -- gadgetzan times
  ["Fara Boltbreaker"] = true, -- gadgetzan times
}

local SilentServer = CreateFrame("Frame","SilentServer")
SilentServer:SetScript("OnEvent", function ()
  SilentServer[event](this,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
end)
SilentServer:RegisterEvent("ADDON_LOADED")

function SilentServer:ADDON_LOADED(addon)
  if addon ~= "SilentServer" then return end
  SilentServerDB = SilentServerDB or {}
end

local orig_ChatFrame_OnEvent = ChatFrame_OnEvent
ChatFrame_OnEvent = function (event,a2,a3,a4,a5,a6,a7,a8,a9,a10)
  local msg = arg1 and string.lower(arg1)
  local from = arg2

  if event == "CHAT_MSG_SYSTEM" then
    for _,pattern in system_patterns do
      if string.find(msg,string.lower(pattern)) then
        return false
      end
    end
    orig_ChatFrame_OnEvent(event,a2,a3,a4,a5,a6,a7,a8,a9,a10)
  elseif event == "CHAT_MSG_MONSTER_YELL" then
    if ignore_npc[from] then
      return false
    end
    orig_ChatFrame_OnEvent(event,a2,a3,a4,a5,a6,a7,a8,a9,a10)
  else
    orig_ChatFrame_OnEvent(event,a2,a3,a4,a5,a6,a7,a8,a9,a10)
  end
end

local T, C, L = unpack(Tukui)

---------------------------------------------------------------
-- Edit Options
---------------------------------------------------------------

-- insert options (IMPORTANT! This need to be added into Tukui_CustomConfig addon if you want it work with Tukui_ConfigUI)
C.actionbar.allbar = true
C.chat.outline = true

-- remove an option, I don't want it in my edit (Need to be done in your edit and NOT in Tukui_CustomConfig)
C.general.multisampleprotect = nil

-- Set the option text for my new option into Tukui_ConfigUI!
if IsAddOnLoaded("Tukui_ConfigUI") then
	TukuiConfigUILocalization.actionbarallbar = "Activate 3 more action bars!"
	-- TukuiConfigUILocalization.chatoutline = "Active Outline on Chat!"
end


print("|cffFF0000[|cff00FF00Tukui|cffFF0000] |cffFF00FFBadgerUI Loaded!|r")
---------------------------------------------------------------
-- Minimap
---------------------------------------------------------------

-- Move minimap to center bottom
TukuiMinimap:ClearAllPoints()
TukuiMinimap:Point("BOTTOM", UIParent, "BOTTOM", 0,20)

-- Resize map
TukuiMinimap:Size(200)
Minimap:Size(200);


TukuiMinimapZone:ClearAllPoints()
TukuiMinimapZone:Point("BOTTOMLEFT", TukuiMinimap, "TOPLEFT", 0, 4)
TukuiMinimapZone:Point("BOTTOMRIGHT", TukuiMinimap, "TOPRIGHT", 0, 4)

TukuiMinimapZone:SetAlpha(1);
TukuiMinimapZoneText:SetAlpha(1);

Minimap:SetScript("OnEnter",nil)
Minimap:SetScript("OnLeave",nil)

TukuiMinimapCoord:ClearAllPoints()
TukuiMinimapCoord:Point("BOTTOMLEFT", TukuiMinimapZone, "TOPLEFT", 0, 3)
TukuiMinimapCoord:Point("RIGHT", TukuiMinimapZone, "CENTER", -30, 0)

TukuiMinimapCoord:SetAlpha(1)
TukuiMinimapCoordText:SetAlpha(1)
TukuiMinimapCoordText:ClearAllPoints()
TukuiMinimapCoordText:Point("CENTER",TukuiMinimapCoord, "CENTER", 0, 0)

TukuiStatTime:ClearAllPoints()
TukuiStatTime:Point("CENTER", TukuiMinimapStatsRight, "CENTER", 0, 0)

-- Not using the left status box. Replaced with coords
TukuiMinimapStatsLeft:Hide()

-- move and resize
TukuiMinimapStatsRight:ClearAllPoints()
TukuiMinimapStatsRight:Point("BOTTOMRIGHT", TukuiMinimapZone, "TOPRIGHT", 0, 3)
TukuiMinimapStatsRight:SetWidth(TukuiMinimapCoord:GetWidth())
TukuiMinimapStatsRight:SetHeight(TukuiMinimapCoord:GetHeight())


--[[
local MinimapZone = CreateFrame("Frame", "TopStatus", UIParent)
MinimapZone:CreatePanel("Default", 0, 20, "TOPLEFT", TukuiMinimap, "TOPLEFT", 2,-2)
MinimapZone:SetFrameLevel(5)
MinimapZone:SetFrameStrata("LOW")
MinimapZone:Point("TOPRIGHT",TukuiMinimap,-2,-2)
MinimapZone:SetAlpha(1)
]]--


---------------------------------------------------------------
-- Action Bars
---------------------------------------------------------------

----------------------------------------------------------------
---------------------- Override bar 2 --------------------------
----------------------------------------------------------------

TukuiBar2:ClearAllPoints()
TukuiBar2:Point("TOPLEFT", TukuiBar1, "BOTTOMLEFT", 0, -3)
TukuiBar2:SetWidth((28 * 12) + (T.buttonspacing * 13))
TukuiBar2:SetHeight((28 * 1) + (T.buttonspacing * 2))

----------------------------------------------------------------
---------------------- Override bar 1 --------------------------
----------------------------------------------------------------

TukuiBar1:ClearAllPoints()
TukuiBar1:Point("TOPRIGHT", TukuiMinimap, "TOPLEFT", -3, 0)
TukuiBar1:SetWidth((60 * 6) + (T.buttonspacing * 7))
TukuiBar1:SetHeight((60 * 2) + (T.buttonspacing * 3))


-- Override bar 2, 3 AND 4
-- Move the left and right side bar up next to minimap

TukuiBar3:ClearAllPoints()
TukuiBar3:Point("TOPLEFT", TukuiMinimap, "TOPRIGHT", 3, 0)

TukuiBar3:SetWidth((60 * 6) + (T.buttonspacing * 7))
TukuiBar3:SetHeight((60 * 2) + (T.buttonspacing * 3))



TukuiBar4:ClearAllPoints()
TukuiBar4:SetPoint("BOTTOMLEFT", TukuiBar3, "TOPLEFT", 0, 4)
TukuiBar4:SetWidth((35 * 10) + ((T.petbuttonspacing-1) * 11)+5)
TukuiBar4:SetHeight(35 + ((T.petbuttonspacing-1) * 2)+2)

local TukuiBar4CDL = CreateFrame("Frame", "TukuiBar3Left", UIParent)
TukuiBar4CDL:CreatePanel("Default", 1, 1, "BOTTOMLEFT", TukuiMinimapCoord, "TOPLEFT", 0, 3)
TukuiBar4CDL:SetWidth(62 + (T.buttonspacing * 2))
TukuiBar4CDL:SetHeight(62 + (T.buttonspacing * 2))
TukuiBar4CDL:SetFrameStrata("BACKGROUND")
TukuiBar4CDL:SetFrameLevel(2)

local TukuiBar4CDR = CreateFrame("Frame", "TukuiBar3Left", UIParent)
TukuiBar4CDR:CreatePanel("Default", 1, 1, "BOTTOMRIGHT", TukuiMinimapStatsRight, "TOPRIGHT", 0, 3)
TukuiBar4CDR:SetWidth(62 + (T.buttonspacing * 2))
TukuiBar4CDR:SetHeight(62 + (T.buttonspacing * 2))
TukuiBar4CDR:SetFrameStrata("BACKGROUND")
TukuiBar4CDR:SetFrameLevel(2)





TukuiBar5:Hide()

-- Modify invisible bar thingy

InvTukuiActionBarBackground:ClearAllPoints()
InvTukuiActionBarBackground:Point("TOPLEFT", TukuiBar1)
InvTukuiActionBarBackground:Point("BOTTOMRIGHT", TukuiBar3)



-------------------------------- bar shite


---------------------------------------------------------------------------
-- Setup Main Action Bar.
-- Now used for stances, Bonus, Vehicle at the same time.
-- Since t12, it's also working for druid cat stealth. (a lot requested)
---------------------------------------------------------------------------


local function GetBar()
  local shd = 7
  if C.actionbar.ownshdbar then shd = 10 end

  local Page = {
    ["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
    ["WARRIOR"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
    ["PRIEST"] = "[bonusbar:1] 7;",
    ["ROGUE"] = "[bonusbar:1] 7; [form:3] "..shd..";",
    ["DEFAULT"] = "[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
  }
	local condition = Page["DEFAULT"]
	local class = T.myclass
	local page = Page[class]
	if page then
		condition = condition.." "..page
	end
	condition = condition.." 1"
	return condition
end

local function BuildBar1(self)

  local bar = TukuiBar1
  --[[ 
    Bonus bar classes id

    DRUID: Caster: 0, Cat: 1, Tree of Life: 0, Bear: 3, Moonkin: 4
    WARRIOR: Battle Stance: 1, Defensive Stance: 2, Berserker Stance: 3 
    ROGUE: Normal: 0, Stealthed: 1
    PRIEST: Normal: 0, Shadowform: 1
    
    When Possessing a Target: 5
  ]]--

  local shd = 7
  if C.actionbar.ownshdbar then shd = 10 end

  local Page = {
    ["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
    ["WARRIOR"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
    ["PRIEST"] = "[bonusbar:1] 7;",
    ["ROGUE"] = "[bonusbar:1] 7; [form:3] "..shd..";",
    ["DEFAULT"] = "[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
  }


  bar:RegisterEvent("PLAYER_LOGIN")
  bar:RegisterEvent("PLAYER_ENTERING_WORLD")
  bar:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
  bar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
  bar:RegisterEvent("BAG_UPDATE")
  bar:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
  bar:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
      local button
      for i = 1, NUM_ACTIONBAR_BUTTONS do
        button = _G["ActionButton"..i]
        self:SetFrameRef("ActionButton"..i, button)
      end	

      self:Execute([[
        buttons = table.new()
        for i = 1, 12 do
          table.insert(buttons, self:GetFrameRef("ActionButton"..i))
        end
      ]])

      self:SetAttribute("_onstate-page", [[ 
        for i, button in ipairs(buttons) do
          button:SetAttribute("actionpage", tonumber(newstate))
        end
      ]])
        
      RegisterStateDriver(self, "page", GetBar())
    elseif event == "PLAYER_ENTERING_WORLD" then
      if T.toc < 40200 then MainMenuBar_UpdateKeyRing() end
      
      local button
      local button2
      for i = 1, 12 do
        button = _G["ActionButton"..i]
        button2 = _G["ActionButton"..i-1]
        --button:SetSize(T.buttonsize, T.buttonsize)
        button:SetSize(60, 60)
        button:ClearAllPoints()
        button:SetParent(bar)
        button:SetFrameStrata("BACKGROUND")
        button:SetFrameLevel(15)

        if i == 1 then
          button:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
        elseif i == 7 then
          button:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, T.buttonspacing)
        else
          button:SetPoint("LEFT", button2, "RIGHT", T.buttonspacing, 0)
        end
      
  --      if i == 1 then
  --        button:SetPoint("BOTTOMLEFT", T.buttonspacing, T.buttonspacing)
  --      else
  --        local previous = _G["ActionButton"..i-1]
  --        button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing, 0)
  --      end
      end

    elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
      -- attempt to fix blocked glyph change after switching spec.
      LoadAddOn("Blizzard_GlyphUI")
    else
      MainMenuBar_OnEvent(self, event, ...)
    end
  end)
end
---end bar shite----------

local function BuildBar2(self)

-- setup bar2
  local bar = TukuiBar2
  MultiBarBottomLeft:SetParent(bar)

  
  for i=1, 12 do
    local b = _G["MultiBarBottomLeftButton"..i]
    local b2 = _G["MultiBarBottomLeftButton"..i-1]
    b:SetSize(28, 28)
    b:ClearAllPoints()
    b:SetFrameStrata("BACKGROUND")
    b:SetFrameLevel(15)
    
    --print(bar:GetWidth())
    if i == 1 then
      b:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, T.buttonspacing)
    --elseif i == 7 then
    --  b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
    end
  end

  for i=7, 12 do
    local b = _G["MultiBarBottomLeftButton"..i]
    local b2 = _G["MultiBarBottomLeftButton1"]
    b:SetFrameLevel(b2:GetFrameLevel() - 2)
  end
  

-- end setup bar 2


end

local function BuildBar3(self)

-- setup bar3
  local bar = TukuiBar3
  MultiBarBottomRight:SetParent(bar)

  
  for i=1, 12 do
    local b = _G["MultiBarBottomRightButton"..i]
    local b2 = _G["MultiBarBottomRightButton"..i-1]
    b:SetSize(60, 60)
    b:ClearAllPoints()
    b:SetFrameStrata("BACKGROUND")
    b:SetFrameLevel(15)
    
    --print(bar:GetWidth())
    if i == 1 then
      b:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, T.buttonspacing)
    elseif i == 7 then
      b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
    end
  end

  for i=7, 12 do
    local b = _G["MultiBarBottomRightButton"..i]
    local b2 = _G["MultiBarBottomRightButton1"]
    b:SetFrameLevel(b2:GetFrameLevel() - 2)
  end
  

-- end setup bar 3


end

local function BuildBar4(self)

---------------------------------------------------------------------------
-- setup MultiBarRight as bar #4
---------------------------------------------------------------------------

  local bar = TukuiBar4
  local bar2 = Create
  bar:SetAlpha(1)
  MultiBarLeft:SetParent(bar)

  for i= 1, 12 do
    local b = _G["MultiBarLeftButton"..i]
    local b2 = _G["MultiBarLeftButton"..i-1]
    --b:SetSize(T.buttonsize, T.buttonsize)
    b:SetSize(35, 35)
    b:ClearAllPoints()
    b:SetFrameStrata("BACKGROUND")
    b:SetFrameLevel(15)
    
    if i == 1 then
      b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
    elseif i == 2 or i == 5 or i == 8 then
      b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
    elseif i == 11 then
      b:SetSize(62, 62)
      b:SetPoint("TOPLEFT", TukuiBar4CDL, T.buttonspacing, -T.buttonspacing)
    elseif i == 12 then
      b:SetSize(62, 62)
      b:SetPoint("TOPLEFT", TukuiBar4CDR, T.buttonspacing, -T.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing-1, 0)
    end
    
  end


end

local function BuildBarPanelSizes(self)

--print("BuildBarPanelSizes called.")

local name = self:GetName()

--print("Name[" .. name .. "]")

-- BAR 1 START
  
  if name.find(name,"^ActionButton") then
      _G[name.."Panel"]:SetSize(T.Scale(60),T.Scale(60))
      --print(name.."Panel")
  end
-- BAR 1 END

-- BAR 2 START
  if name.find(name,"^MultiBarBottomLeftButton") then
      _G[name.."Panel"]:SetSize(T.Scale(28),T.Scale(28))
      --print(name.."Panel")
  end
-- BAR 2 END

-- BAR 3 START
  if name.find(name,"^MultiBarBottomRightButton") then
      _G[name.."Panel"]:SetSize(T.Scale(60),T.Scale(60))
      --print(name.."Panel")
  end
-- BAR 3 END

-- BAR 4 START
  if name.find(name,"^MultiBarLeftButton") then
    local bnum = name.match(name, '%d+',15)
    if (bnum+0) == 11 or (bnum+0) == 12 then
      _G[name.."Panel"]:SetSize(T.Scale(62),T.Scale(62))
      --print("name["..name.."] -> "..bnum)
    else
      _G[name.."Panel"]:SetSize(T.Scale(35),T.Scale(35))
      --print("name["..name.."] -> "..bnum)
    end
  end
-- BAR 4 END
end
local function BuildBars(self)
  BuildBar1(self)
  BuildBar2(self)
  BuildBar3(self)
  BuildBar4(self)
  BuildBarPanelSizes(self)
end

hooksecurefunc("ActionButton_Update", BuildBars)

-- Disable the pet par adjoining visual element.
TukuiLineToPetActionBarBackground:Hide()

-- move the pet bar
TukuiPetBar:ClearAllPoints()
TukuiPetBar:SetPoint("BOTTOMLEFT", TukuiBar1, "TOPLEFT", 0, 4)
TukuiPetBar:SetWidth((T.petbuttonsize * 10) + ((T.petbuttonspacing-1) * 11)+5)
TukuiPetBar:SetHeight(T.petbuttonsize + ((T.petbuttonspacing-1) * 2)+2)

local petbar = TukuiPetBar
local link = TukuiLineToPetActionBarBackground

petbar:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" then	
		-- bug reported by Affli on t12 BETA
		PetActionBarFrame.showgrid = 1 -- hack to never hide pet button. :X
		
		local button		
		for i = 1, 10 do
			button = _G["PetActionButton"..i]
			local b2 = _G["PetActionButton"..i-1]
			button:ClearAllPoints()
			button:SetParent(TukuiPetBar)
			button:SetSize(T.petbuttonsize, T.petbuttonsize)
			
			if i == 1 then
        button:SetPoint("BOTTOMLEFT", petbar, T.petbuttonspacing, T.petbuttonspacing)
      elseif i == 3 or i == 4 or i == 8 then
        button:SetPoint("LEFT", b2, "RIGHT", T.petbuttonspacing, 0)
      else
        button:SetPoint("LEFT", b2, "RIGHT", T.petbuttonspacing-1, 0)
      end
      button:Show()
      self:SetAttribute("addchild", button)
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", T.TukuiPetBarUpdate)
	elseif event == "PET_BAR_UPDATE" or event == "UNIT_PET" and arg1 == "player" 
	or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED" or event == "UNIT_FLAGS"
	or arg1 == "pet" and (event == "UNIT_AURA") then
		T.TukuiPetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	else
		T.StylePet()
	end
end)

-- Always hide ShapeShift!
TukuiShiftBar:Kill()

-- kill the show/hide button because they doesn't fit my new bar layout
TukuiBar2Button:Kill()
TukuiBar3Button:Kill()
TukuiBar4Button:Kill()
TukuiBar3Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()

---------------------------------------------------------------
-- Panels
---------------------------------------------------------------
--temporary crap to position omen...
--[[
local pOmen = CreateFrame("Frame", "PanelOmen", UIParent)
pOmen:SetWidth(200)
pOmen:SetHeight(23)
pOmen:SetFrameLevel(2)
pOmen:SetFrameStrata("BACKGROUND")
pOmen:SetTemplate()
pOmen:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -1850, 70)
]]--

--[[
-- I want to hide some panels, because I don't like it
local panels = { TukuiInfoRight, TukuiInfoLeftLineVertical, TukuiInfoRightLineVertical, TukuiCubeLeft, TukuiCubeRight, TukuiLineToABLeft, TukuiLineToABRight}
for _, panel in pairs(panels) do
	panel:Kill()
end

-- I want Tukui Info Left at the bottom
TukuiInfoLeft:ClearAllPoints()
TukuiInfoLeft:SetParent(UIParent)
TukuiInfoLeft:SetPoint("BOTTOM", 0, 10)
--]]
-- I want Tukui Info Left resized to fit my main action bar
-- TukuiInfoLeft:Width(TukuiBar1:GetWidth() - 8)

--[[
local pTop = CreateFrame("Frame", "TopStatus", UIParent)
pTop:SetWidth(200)
pTop:SetHeight(23)
pTop:SetFrameLevel(2)
pTop:SetFrameStrata("BACKGROUND")
pTop:SetTemplate()
pTop:SetPoint("TOP", UIParent, "TOP", 0, 0)
]]--

--fixing the crummy layout of various things since they use a template
--value we cant really change :(

local NewWidthVar = 500
local NewHeightLeft = 500

--ileft
TukuiInfoLeft:Width(NewWidthVar)
--iright
TukuiInfoRight:Width(NewWidthVar)

--chatleftbg
TukuiChatBackgroundLeft:Width(NewWidthVar+12)
TukuiChatBackgroundLeft:Height(NewHeightLeft+12)

--chatrightbg
TukuiChatBackgroundRight:Width(NewWidthVar+12)

--tabsbgleft
TukuiTabsLeftBackground:Width(NewWidthVar)

--tabsbgright
TukuiTabsRightBackground:Width(NewWidthVar)

-- The two lines to the minimap/bars. Do not want :p
TukuiLineToABLeftAlt:Hide()
TukuiLineToABRightAlt:Hide()

TukuiLineToABLeft:ClearAllPoints()
TukuiLineToABLeft:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -(NewWidthVar + 16), 211)
TukuiLineToABLeft:Point("BOTTOMRIGHT", TukuiMinimap, "BOTTOMLEFT", 0, 0)
TukuiLineToABLeft:SetAlpha(0)

TukuiLineToABRight:ClearAllPoints()
TukuiLineToABRight:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -(NewWidthVar + 16), 0)
TukuiLineToABRight:Point("BOTTOMRIGHT", TukuiMinimap, "BOTTOMLEFT", 0, 0)
TukuiLineToABRight:SetAlpha(0)


TukuiInfoRight:ClearAllPoints()
TukuiInfoRight:Point("LEFT", TukuiLineToABLeft, "LEFT", 4, 0)
TukuiInfoRight:Point("BOTTOM", UIParent, "BOTTOM", 0, 20)


--TukuiLineToABRight:ClearAllPoints()
--TukuiLineToABRight:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 50);

---------------------------------------------------------------
-- Chats
---------------------------------------------------------------

-- Set/Reset chat window size.

-- default position of chat #1 (left) and chat #4 (right)
T.SetDefaultChatPosition = function(frame)
  if frame then
    local id = frame:GetID()
    local name = FCF_GetChatWindowInfo(id)

    frame:SetJustifyH("LEFT")
    if id == 1 then
      if C.chat.background then
        frame:ClearAllPoints()
        frame:Point("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", 0, 0)
        frame:Point("BOTTOMRIGHT", TukuiInfoLeft, "TOPRIGHT", 0, 0)
      else
        _G[chat]:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 16, 16)
      end
      -- set the size of chat frame
      frame:Size(NewWidthVar + 1, 451)
      -- tell wow that we are using new size
      SetChatWindowSavedDimensions(id, NewWidthVar + 1, 451)
    elseif id == 4 and name == LOOT then
      if not frame.isDocked then
        frame:ClearAllPoints()
        if C.chat.background then
          frame:Point("BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 0, 0)
          frame:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", 0, 0)
        else
          frame:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -16, 16)
        end
        -- set the size of chat frame
        frame:Size(NewWidthVar + 1, 116)
        -- tell wow that we are using new size
        SetChatWindowSavedDimensions(id, NewWidthVar + 1, 116)
      end
    else
      -- set the size of chat frames not defined above
      frame:Size(NewWidthVar + 1, 200)
      SetChatWindowSavedDimensions(id, NewWidthVar + 1, 200)
    end
    
    -- save new default position and dimension
    FCF_SavePositionAndDimensions(frame)
    
    -- lock them if unlocked
    if not frame.isLocked then FCF_SetLocked(frame, 1) end
  end
end
hooksecurefunc("FCF_RestorePositionAndDimensions", T.SetDefaultChatPosition)


--[[
TukuiChat:HookScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		if C.chat.outline then
			for i = 1, NUM_CHAT_WINDOWS do
				local chat = _G[format("ChatFrame%s", i)]
				local font, size = chat:GetFont()
				chat:SetFont(font, size, "OUTLINE")
			end
		end
		
		-- set the default chat #1 position
--		ChatFrame1:ClearAllPoints()
--		ChatFrame1:SetPoint("BOTTOMLEFT", 15, 15)
		
	end
end)
]]--
---------------------------------------------------------------
-- Buffs
---------------------------------------------------------------
--[[
-- lets move them on right of minimap
TukuiAurasPlayerBuffs:ClearAllPoints()
TukuiAurasPlayerBuffs:Point("TOPLEFT", TukuiMinimap, "TOPRIGHT", 6, 0)
]]--
---------------------------------------------------------------
-- UnitFrames
---------------------------------------------------------------

-- Move Player above PetBar
TukuiPlayer:ClearAllPoints()
TukuiPlayer:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0, TukuiPetBar:GetHeight()+16)

-- Move Target to same height as Player for symetrical OCD.
TukuiTarget:ClearAllPoints()
TukuiTarget:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0, TukuiPetBar:GetHeight()+16)

-- Move TargetOfTarget
TukuiTargetTarget:ClearAllPoints()
TukuiTargetTarget:SetPoint("RIGHT", TukuiTarget, "LEFT", -4,0)

-- Move Pet to mirror the TargetOfTarget for symetrical OCD.
TukuiPet:ClearAllPoints()
TukuiPet:SetPoint("LEFT", TukuiPlayer, "RIGHT", 4,0)

--TukuiTargetTarget:Size(129,57)
--[[
local units = {
	"Player",
	"Target",
	"TargetTarget",
	"Pet",
	"Focus",
}

for _, frame in pairs(units) do
	local t = "Tukui"
	local self = _G[t..frame]
	local unit = string.lower(frame)
	
	-- if we see a shadow around on a unit frame, kill it!
	if self.shadow then
		self.shadow:Kill()
	end
	
	-- player stuff
	if unit == "player" then		
		-- kill the panel
		self.panel:Kill()
		
		-- resize the frame
		self:Height(35)
		
		-- resize health & power
		self.Health:Height(17)
		self.Power:Height(17)
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, -200, 230)
		
		-- kill reputation bar
		local reputation = TukuiPlayer_Reputation
		reputation:Kill()
	end
	
	if unit == "target" then
		-- kill the panel
		self.panel:Kill()
		
		-- resize the frame
		self:Height(35)
		
		-- resize health & power
		self.Health:Height(17)
		self.Power:Height(17)
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, 200, 230)
		
		-- change the font of name into target
		self.Name:SetFont(C.media.font, 12, "OUTLINE")
		self.Name:SetParent(self.Health)
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", 0, -9)
		
		-- I want to have this name stay where it is for ever
		-- (because in tukui we have a script where it move the name according to some events)
		self.Name.ClearAllPoints = T.dummy
		self.Name.SetPoint = T.dummy	
	end
	
	if unit == "targettarget" or unit == "pet" then
		-- I don't want to use pet and targettarget into my edit
		self:ClearAllPoints()
	end
end
]]--
---------------------------------------------------------------------------------
-- Data Text
---------------------------------------------------------------------------------
--[[
-- our own datatext position function because we made our custom panel
local DataTextPosition = function(f, t, o)
	local left = MyEditStatInfoLeft
	local middle = MyEditStatInfoMiddle
	local right = MyEditStatInfoRight
	
	if o >= 1 and o <= 6 then
		-- 1 to 3 use a default tukui panel, no need to update
		-- just update 4 to 6
		if o == 4 then
			t:ClearAllPoints()
			t:SetParent(left)
			t:SetHeight(left:GetHeight())
			t:SetPoint("CENTER")		
		elseif o == 5 then
			t:ClearAllPoints()
			t:SetParent(middle)
			t:SetHeight(middle:GetHeight())
			t:SetPoint("CENTER")		
		elseif o == 6 then
			t:ClearAllPoints()
			t:SetParent(right)
			t:SetHeight(right:GetHeight())
			t:SetPoint("CENTER")		
		end
	else
		-- hide everything that we don't use and enabled by default on tukui
		f:Hide()
		t:Hide()
	end
end

-- Tukui DataText List
local datatext = {
	"Guild",
	"Friends",
	"Gold",
	"FPS",
	"System",
	"Bags",
	"Gold",
	"Time",
	"Durability",
	"Heal",
	"Damage",
	"Power",
	"Haste",
	"Crit",
	"Avoidance",
	"Armor",
	"Currency",
	"Hit",
	"Mastery",
	"MicroMenu",
	"Regen",
	"Talent",
	"CallToArms",
}

-- Overwrite & Update Show/Hide/Position of all Datatext
for _, data in pairs(datatext) do
	local t = "TukuiStat"
	local frame = _G[t..data]
	local text = _G[t..data.."Text"]

	if frame and frame.Option then
		DataTextPosition(frame, text, frame.Option)
	end
end
]]--
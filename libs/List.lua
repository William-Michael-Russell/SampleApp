local wm = WINDOW_MANAGER

local TITLE_HEIGHT = 24
local LINES_OFFSET = TITLE_HEIGHT
local SLIDER_WIDTH = 22

-- Make self available to everything in this file
local self = {}

-- Utility

local function clamp(val, min_, max_)
  val = math.max(val, min_)
  return math.min(val, max_)
end

----------------------------------------------------
---  Function to kick guild members.
-----------------------------------------------------
local function KickHisAss(index, string)
--First check if YOU have permissions to remove players.
  if DoesPlayerHaveGuildPermission(GetGuildId(index), GUILD_PERMISSION_REMOVE) then
    GuildRemove(GetGuildId(index), string)
    d(string .. "Was Removed from the guild")
  else
    d("You don't have guild permission to remove players.")
  end
end



-- Private API
local function _set_line_counts(self)
  self.num_visible_lines = math.floor((self.control:GetHeight() - LINES_OFFSET) / self.line_height)
  self.num_visible_lines = math.min(self.num_visible_lines, #self.lines)

  self.num_hidden_lines = math.max(0, #self.lines - self.num_visible_lines)
  if self.num_hidden_lines == 0 then
    self.offset = 0
  end
end

local function _create_listview_row(self, i)
  local control = self.control
  local name = control:GetName() .. "_list" .. i

------------------------------------------------------------------------------
--You can add a LABEl/ Button ETC for each array index you've made -----
--
--Example: 
-- e.GuildName we saved into SampleGetGuildName in SampleGuildChecker.lua
-- From there we added SampleGetGuildName to the message (bottom of this file)
-- Message was then turned into self.lines
-- ------------------------------------------------------------------------------
--
  local list = wm:CreateControl(name, control, CT_CONTROL)
  list:SetHeight(self.line_height)

  local message = self.lines[i]
  
  -------------------------------------------------------------------------------------
  --For e.GuildName, or self.lines.GuildName or message.GuildName I've made  a label
  --------------------------------------------------------------------------------------
  if message ~= nil then
    if message.GuildName ~= nil then
      list.guild = wm:CreateControl(name .. "_Guild", list, CT_LABEL)
      list.guild:SetFont("ZoFontGame")
      list.guild:SetColor(255, 255, 255, 1)
      list.guild:SetText(message.GuildName)
      list.guild:SetAnchor(0, list, 0, LEFT, 20)
    end

    if message.GuildMember ~= nil then
      list.player = wm:CreateControl(name .. "_Player", list, CT_LABEL)
      list.player:SetFont("ZoFontGame")
      list.player:SetColor(255, 255, 255, 1)
      list.player:SetText( message.GuildMember)
      list.player:SetAnchor(0, list, 0, LEFT + 150, 20)
    end

    if message.formattedPlayerTime ~= nil then
      list.secs = wm:CreateControl(name .. "_Secs", list, CT_LABEL)
      list.secs:SetFont("ZoFontGame")
      list.secs:SetColor(255, 255, 255, 1)
      list.secs:SetText("Weeks: " .. message.formattedPlayerTime)
      list.secs:SetAnchor(0, list, 0, LEFT + 300, 20)
    end

    if message.GuildMemberRankIndex ~= nil then
      list.rank = wm:CreateControl(name .. "_Rank", list, CT_LABEL)
      list.rank:SetFont("ZoFontGame")
      list.rank:SetColor(255, 255, 255, 1)
      list.rank:SetText(" Rank: " .. message.GuildMemberRankIndex)
      list.rank:SetAnchor(0, list, 0, LEFT + 360, 20)
    end

    if message.level ~= nil then
      list.level = wm:CreateControl(name .. "_Level", list, CT_LABEL)
      list.level:SetFont("ZoFontGame")
      list.level:SetColor(255, 255, 255, 1)
      list.level:SetText("  Lvl: " .. message.level)
      list.level:SetAnchor(0, list, 0, LEFT + 400, 20)
    end
    if message.GuildMember ~= nil then
      list.kickMember = wm:CreateControl(name .. "Kick", list, CT_BUTTON)
      list.kickMember:SetFont("ZoFontGame")
      list.kickMember:SetDimensions(200,25)
      list.kickMember:SetText("Remove From Guild")
      list.kickMember:SetAnchor(0, list, 0, LEFT + 450, 20)
      list.kickMember:SetHandler("OnClicked", function() KickHisAss(message.GuildIndex, message.GuildMember) end)
    end

    return list
  end
end
 
 ---- Just testing stuff
function testingagain()
  local message = self.lines
  d(message)
end

local function _create_listview_lines_if_needed(self)
  local control = self.control

  -- Makes sure that the main control is filled up with line controls at all times.
  for i = 1, self.num_visible_lines do
    if control.lines[i] == nil then
      local line = _create_listview_row(self, i)
      control.lines[i] = line
      if i == 1 then
        line:SetAnchor(TOPLEFT, control, TOPLEFT, 0, LINES_OFFSET)
      else
        line:SetAnchor(TOPLEFT, control.lines[i - 1], BOTTOMLEFT, 0, 0)
      end
    end
  end
end

local function _on_resize(self)
  local control = self.control

  -- Need to calculate num_visible_lines etc. for the rest of this function.
  _set_line_counts(self)

  _create_listview_lines_if_needed(self)

  -- Represent how many lines are visible atm.
  local viewable_lines_pct = self.num_visible_lines / #self.lines

  -- Can we see all the lines?
  if viewable_lines_pct >= 1.0 then
    control.slider:SetHidden(true)
  else
    -- If not, make sure the slider is showing.
    control.slider:SetHidden(false)
    self.control.slider:SetMinMax(0, self.num_hidden_lines)
    control.slider:SetHeight(control:GetHeight() - LINES_OFFSET)

    -- The more lines we can see, the bigger the slider should be.
    local tex = self.slider_texture
    -- TODO: I have no idea why I need to do "+ 8" to get it to fit here.. GOD I hate low level UI API's.
    control.slider:SetThumbTexture(tex, tex, tex, SLIDER_WIDTH + 8, control.slider:GetHeight() * viewable_lines_pct, 0, 0, 1, 1)
  end

  -- Update line widths in case we just resized self.control.
  local line_width = control:GetWidth()
  if not control.slider:IsControlHidden() then
    line_width = line_width - control.slider:GetWidth()
  end

  for _, line in pairs(control.lines) do
    line:SetWidth(line_width)
  end
end

local function _initialize_listview(self, width, height, left, top)
  local control = self.control
  local name = control:GetName()

  -- control
  control:SetDimensions(width, height)
  control:SetHidden(false)
  control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
  control:SetMovable(true)
  control:SetResizeHandleSize(MOUSE_CURSOR_RESIZE_NS)
  control:SetMouseEnabled(true)
  control:SetClampedToScreen(true)

  -- control backdrop
  control.bd = wm:CreateControl(name .. "_Backdrop", control, CT_BACKDROP)
  control.bd:SetCenterColor(0, 0, 0, 0.6)
  control.bd:SetEdgeColor(0, 0, 0, 0)
  control.bd:SetAnchorFill(control)

  -- title
  if self.title then
    control.title = wm:CreateControl(name .. "_Title", control, CT_LABEL)
    control.title:SetFont("ZoFontGame")
    control.title:SetColor(255, 255, 255, 1)
    control.title:SetText("Guild")
    control.title:SetHeight(TITLE_HEIGHT)
    control.title:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
    control.title:SetAnchor(TOPRIGHT, control, TOPRIGHT, 0, 0)

    -- title backdrop
    control.title.bd = wm:CreateControl(name .. "_Title_Backdrop", control.title, CT_BACKDROP)
    control.title.bd:SetCenterColor(0, 0, 0, 0.7)
    control.title.bd:SetEdgeColor(0, 0, 0, 0)
    control.title.bd:SetAnchorFill(control.title)
  end

  -- close button
  control.close = wm:CreateControl(name .. "_Close", control, CT_BUTTON)
  control.close:SetDimensions(20, TITLE_HEIGHT)
  control.close:SetAnchor(TOPRIGHT, control, TOPRIGHT, 0, 0)
  control.close:SetFont("ZoFontGame")
  control.close:SetText("X")

  -- close backdrop
  control.close.bd = wm:CreateControl(name .. "_Close_Backdrop", control.close, CT_BACKDROP)
  control.close.bd:SetCenterColor(0, 0, 0, 1)
  control.close.bd:SetEdgeColor(0, 0, 0, 0)
  control.close.bd:SetAnchorFill(control.close)

  -- slider
  local tex = self.slider_texture
  control.slider = wm:CreateControl(name .. "_Slider", control, CT_SLIDER)
  control.slider:SetWidth(SLIDER_WIDTH)
  control.slider:SetMouseEnabled(true)
  control.slider:SetValue(0)
  control.slider:SetValueStep(1)
  control.slider:SetAnchor(TOPRIGHT, control.close, BOTTOMRIGHT, 0, 0)

  -- lines
  control.lines = {}
  _on_resize(self) -- sets important datastructures
  _create_listview_lines_if_needed(self)

  local me = self

  -- event: close button
  control.close:SetHandler("OnClicked", function(self, but)
    control:SetHidden(true)
  end)

  -- event: mwheel
  control:SetHandler("OnMouseWheel",function(self, delta)
    me.offset = clamp(me.offset - delta, 0, me.num_hidden_lines)
    control.slider:SetValue(me.offset)
    me:update()
  end)

  -- event: slider
  control.slider:SetHandler("OnValueChanged", function(self, val, eventReason)
    me.offset = clamp(val, 0, me.num_hidden_lines - 1)
    me:update()
    
    

  end)

  -- event: resize
  control:SetHandler("OnResizeStart", function (self)
    me.currently_resizing = true
  end)

  control:SetHandler("OnResizeStop", function (self)
    me.currently_resizing = false
    _on_resize(me)
    me:update()
  end)

  -- event: control update
  control:SetHandler("OnUpdate", function(self, elapsed)
    me:update()
  end)
end

-- ListView, public API

local ListView = {}

function ListView.new(control, settings)
  settings = settings or {}

  -- Not storing these in self; use self.control:GetWidth() and self.control:GetHeight()
  local width = settings.width or 400
  local height = settings.height or 400
  local left = settings.left or 100
  local top = settings.top or 100

  self = {
    line_height = settings.line_height or 20,
    slider_texture = settings.slider_texture or "/esoui/art/miscellaneous/scrollbox_elevator.dds",
    title = settings.title, -- can be nil

    control = control,
    name = control:GetName(),

    offset = 0,
    lines = {},
    currently_resizing = false,
  }

  -- TODO: Translate self:SetHidden() etc. to self.control:SetHidden()
  setmetatable(self, {__index = ListView})

  _initialize_listview(self, width, height, left, top)

  return self
end

function ListView:update()
  local throttle_time = self.currently_resizing and 0.02 or 0.1
  if Unicorn.throttle(self, 0.05) then
    return
  end

  if self.currently_resizing then
    _on_resize(self)
  end

  -- Goes through each line control and either shows a message or hides it.
  for i, list in pairs(self.control.lines) do
    local message = self.lines[i + self.offset] -- self.offset = how much we've scrolled down

    -- Only show messages that will be displayed within the control.
    if message ~= nil and i <= self.num_visible_lines then

      ---------------------------------------------------------------------------------
      ------- NOTE THESE NIL CHECKS ARE STUPID. PLEASE AVOID THEM.. I'M BEING LAZY ----
      --------------------------------------------------------------------------------
      --TODO UPDATE THESE NIL CHECKS   I need to clean the list and remove nil variables.
      --
      ---------------------------------------------------------------------------------------
      --When we scroll we'll update the next automatically here ------
      ------------------------------------------------------------------

      if message.GuildName ~= nil then
        list.guild:SetText(message.GuildName)
      end
      if message.GuildMember ~= nil then
        list.kickMember:SetText("Remove Player")
      end
      if message.level ~= nil then
        list.level:SetText("Lvl: " .. message.level)
      end
      if message.GuildMemberRankIndex ~= nil then
        list.rank:SetText("Rank: " .. message.GuildMemberRankIndex)
      end
      if message.formattedPlayerTime ~= nil then
        list.secs:SetText("Weeks: " .. message.formattedPlayerTime)
      end
      if message.GuildMember ~= nil then
        list.player:SetText( message.GuildMember)
      end
      if message.GuildName~= nil then
        list.guild:SetText(message.GuildName)
      end
      list:SetHidden(false)
    else
      list:SetHidden(true)
    end
  end
end
---------------------------
--Refresh button from UI--
----------------------------
function RefreshGuildList()
  CheckGuildMemeberStatus()
end

function ListView:clear()
  ListView = {}
  self.lines = {}
  self:update()
end


-----------------------------------------------------------------------------------------------------------------
--e = {} turned into SampleGetGuildName{} and was passed inside sampleAppList:add_message(SampleGetGuildName) 
--From here we've turned it into 'message' and then add each pair value into self.lines
---------------------------------------------------------------------------------------------------------------
function ListView:add_message(message)
  self.lines = {}
  for k,v in pairs(message) do self.lines[k] = v
    table.insert(self.lines, message)
  end
  _on_resize(self) -- maybe the function needs a better name :)
end

Unicorn.ListView = ListView




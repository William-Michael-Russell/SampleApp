--Welcome to the SampleApp. I'll try to keep this application simple and easy to follow. Expect plenty of notes.
sampleApp = {}  -- Since we're using global variables, let's keep them inside 1 main name to save global name space.
sampleApp.var = {
  appName               = "SampleApp",  -- The same name inside SampleApp.txt
  control               = {},
  welcomeMsg            = "Welcome to the Sample Application",
  loadMessageInterval   = 5,
  isAddonLoaded         = false,
  color                 = {
    colMagic     = "|c2dc50e", -- Magic Green (Uncommon)
    colTrash     = "|c777777", -- Trash Gray (Garbage)
    colYellow    = "|cFFFF00" ,--yellow
    colArcane    = "|c3689ef", -- Arcane Blue (Rare)
    colArtifact  = "|c912be1", -- Epic (Epic)
    colTeal      = "|c00FFFF", -- teal
    colWhite     = "|cFFFFFF", -- white
    colRed       = "|cFF0000", -- Red
    colLegendary = "|cd5b526", -- Legendary Gold (TheShit)
    colGreen     = "|c00FF00" --green
  },
}
--This is our saved variable. This variable will be written to file and persist between /reloadui or exiting the game.
mSampSavedVars = {}

local function ImaSlashCommand(withInput)
  sampV("You've just triggered the slash command! Good job")
  sampD("This is a debug message.")
  d("try typing /sampleapp hello")
  if withInput == "hello" then
    d(withInput .. sampleApp.var.color.colRed .. " you Sexy Devil you...")
  end
end


--This event we have setup in our SampleApp.xml "OnUpdate" Careful with this update, its basically "brute force"
function SampleAppOnUpdate()
  if sampleApp.var.isAddonLoaded then
    -- if isAddonLoaded is false, we'll load a message after 15 seconds or so.
    if BufferReached("SampleAppAddonLoadMessage", sampleApp.var.loadMessageInterval) then
      d(sampleApp.var.color.colArcane.. "Sample Application " .. sampleApp.var.color.colWhite.. "Loaded after " .. sampleApp.var.loadMessageInterval .. " sec(s)")
      sampD("Please type /sampleapp to test your slash command")
      sampleApp.var.isAddonLoaded = false -- set to false to stop receiving "loaded messages"
    end
  end
end


local function MailBoxIsOpen()
  sampV("You've opened the mailbox")
end

local function MailBoxIsClosed()
  sampD("You've closed the mailbox")
end


--When your AddOn loads you'll want to register for other events, and initialize your saved variables.
local function OnAddOnLoaded(eventCode, addOnName)
  if (sampleApp.var.appName ~= addOnName) then return end
  sampleApp.var.isAddonLoaded = true
  SampleAppSetupUI(addOnName) -- This is where we'll setup our User Interface
  local Default = {
    ["logV"]                     = true,
    ["logD"]                     = true,
    ["LogE"]                     = true,
    ["loadMessageDelay"]         = 15,
    ["showOnUpdateSpam"]         = false
  }

  -- This is the event which will register your saved variables to load from
  -- C:\Users\yourname\Documents\Elder Scrolls Online\live\SavedVariables\SampleApp.lua
  mSampSavedVars = ZO_SavedVars:New( "SampleApp_Saved_Variable", 1, nil, Default, nil )
  -- SampleApp_Saved_Variable  was named inside of SampleApp.txt


  --Notice in the event we register below we pass sampleApp.var.appName, this way we can change our appName quickly in 1 line
  --Instead of changes it in tons of places.
  EVENT_MANAGER:RegisterForEvent(sampleApp.var.appName,  EVENT_MAIL_OPEN_MAILBOX, MailBoxIsOpen)
  -- The above event will alert the user when the mailbox was opened.


  EVENT_MANAGER:RegisterForEvent(sampleApp.var.appName,  EVENT_MAIL_CLOSE_MAILBOX, MailBoxIsClosed)
  -- The above event will alert the user when the mailbox was closed.
end

EVENT_MANAGER:RegisterForEvent(sampleApp.var.appName, EVENT_ADD_ON_LOADED, OnAddOnLoaded)

---- How to make a slash command!
SLASH_COMMANDS["/sampleapp"]= ImaSlashCommand
  -- Try typing /slasherz in game 
  -- Also try typing /slashers hello, you'll see your output
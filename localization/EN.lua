-------------------------------------------------------------
--- Localization: The most annoying thing you'll ever do!  --
-- ----------------------------------------------------------

        ---------------------------------------------------------------- 
        -- ZO_CreateStringID is a ESO method we're going to be using ---
        ----------------------------------------------------------------
local mkstr = ZO_CreateStringId
        --------------------------------------------------------------------------------------------
        --- sampleApp.SI is adding the SI in the variable we declared from SampleApp.lua (globals). --
        --------------------------------------------------------------------------------------------
local SI = sampleApp.SI

--------------------------------------------------------------------------------------------
--- In SampleApp.lua you see  welcomeMsg = SI.get(SI.WELCOMEMSG),
-- This is basically just setting the string depending on which language the user is in. 
-- In English its the same as  welcomeMsg = "This is a localized message"
-- -------------------------------------------------------------------------------------------
mkstr(SI.WELCOMEMSG,                              "This is a localized message")
mkstr(SI.REFRESH,                              "Refresh")


--- Also Open up core.SI
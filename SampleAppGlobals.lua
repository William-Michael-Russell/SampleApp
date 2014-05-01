
      ---------------------------------------------------------------------------------------------------------------
      -- Since we're using global variables, let's keep them inside 1 main name to save global name space.
      ---------------------------------------------------------------------------------------------------------------
      ---- See this thread http://www.esoui.com/forums/showthread.php?t=1177
sampleApp = {}  
sampleApp.win =   {
      wm = WINDOW_MANAGER,
      Main_Control = {},
}
sampleApp.var = {
  appName               = "SampleApp",  -- The same name inside SampleApp.txt
  controls               = {},  
  ----------------------------------------------------------------------------------------------------
  -- Woah WTF IS this? SI.Huh?   --  Please open Localization.EN to see what Welcome msg does
  ----------------------------------------------------------------------------------------------------
  welcomeMsg            = "HELLO",
  loadMessageInterval   = 5,
  isAddonLoaded         = false,   --- Once the addon has loaded, we'll set this to true. Handy method. 
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
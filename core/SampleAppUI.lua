-- This is how we'll setup LibAddonMenu. Make sure you have this in YourApp.txt
local LAM = LibStub( 'LibAddonMenu-1.0' )
if ( not LAM ) then return end

local function SetupOptionsMenu(index)

  local optionsPanel = LAM:CreateControlPanel(sampleApp.var.appName.. index.. "ControlPanel", "SampleApp")
    if optionsPanel ~= nil then
    LAM:AddHeader(optionsPanel, sampleApp.var.appName.. "Header" .. index,  mFSHConfig.col.colArtifact .."Sample Application ")

    LAM:AddCheckbox(optionsPanel, sampleApp.var.appName.. index.. "EnableVerboseLogging", "Enable Verbose Logging?", "This will Spam your client with developer logs",
      function() return mSampSavedVars.logV end,
      function(val) mSampSavedVars.logV = val
      end)

    LAM:AddCheckbox(optionsPanel, sampleApp.var.appName..index..  "EnableDebugLogging", "Enable Debug Logging?", "This will inform you with debug logs",
      function() return mSampSavedVars.logD end,
      function(val) mSampSavedVars.logD = val
      end)

    LAM:AddCheckbox(optionsPanel, sampleApp.var.appName..index..  "EnableErrorLogging", "Enable Error Logging?", "This will inform you with error logs",
      function() return mSampSavedVars.logE end,
      function(val) mSampSavedVars.logE = val
      end)


    LAM:AddHeader(optionsPanel, sampleApp.var.appName..index..  "LibAnimation", sampleApp.var.color.colArtifact .. "\n Pawkette LibAnimation  \n" .. sampleApp.var.color.colWhite.." http://www.esoui.com/downloads/info54-LibAnimation-1.0.html")
    LAM:AddHeader(optionsPanel, sampleApp.var.appName..index..  "LibStub", sampleApp.var.color.colArtifact .. "Seerah LibStub \n" .. sampleApp.var.color.colWhite.." http://www.esoui.com/downloads/info44-LibStub.html")
    LAM:AddHeader(optionsPanel, sampleApp.var.appName.. index.. "LibAddonMenu", sampleApp.var.color.colArtifact .. "Seerah LibAddonMenu \n" .. sampleApp.var.color.colWhite.." http://www.esoui.com/downloads/info7-LibAddonMenu.html")
    LAM:AddHeader(optionsPanel, sampleApp.var.appName.. index.. "IAcceptGoldz!", sampleApp.var.color.colArtifact .. "\n\n\n\nThe only good donations are\n" .. sampleApp.var.color.colLegendary .. "  gold donations ;)" .. sampleApp.var.color.colWhite.." @awesomebilly: ")
  end
end


local function SetupUI()
  v = 0

end




function SampleAppSetupUI(addOnName)
if "SampleApp" ~= addOnName then return end
  SetupOptionsMenu(addOnName)
    --  SetupUI()  -- Future Release
  

end
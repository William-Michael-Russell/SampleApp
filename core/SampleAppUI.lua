-- This is how we'll setup LibAddonMenu. Make sure you have this in YourApp.txt
local LAM = LibStub( 'LibAddonMenu-1.0' )
if ( not LAM ) then return end   -- LibAddon Library
local SI = sampleApp.SI ---- used for localization






local function SetupOptionsMenu(index)
  local optionsPanel = LAM:CreateControlPanel(sampleApp.var.appName.. index.. "ControlPanel", "SampleApp")
  if optionsPanel ~= nil then
    LAM:AddHeader(optionsPanel, sampleApp.var.appName.. "Header" .. index,  "Sample Application ")

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




local function HideUIz()
  ------------------------------------------------------------------------------------------------------------------
  --By Setting This hidden.. it will hide the entire Main Control UI with everything that is attached to it
  --------------------------------------------------------------------------------------------------------------------
  sampleApp.win.Main_Control:SetHidden(true)
end







local function SetupUI()

  --------------------------------------------------------------------------------------------------------------
  --Main Controller. Please notice that sampleApp.win comes from our globals variables, as does sampleApp.win.wm
  -----------------------------------------------------------------------------------------------------------------
  sampleApp.win.Main_Control = sampleApp.win.wm:CreateTopLevelWindow("SampleApplicationMainController")
  sampleApp.win.Main_Control:SetMovable(true)
  sampleApp.win.Main_Control:SetMouseEnabled(true)
  sampleApp.win.Main_Control:SetDimensions(500,400)
  sampleApp.win.Main_Control:SetHidden(false)
  sampleApp.win.Main_Control:SetAlpha(1)
  sampleApp.win.Main_Control:SetResizeHandleSize(MOUSE_CURSOR_RESIZE_NS)

  -- Simple Back Drop to watch FPS has nothing to do with overall UI except to show you a backdrop
  local mBackDrop = sampleApp.win.wm:CreateControl("SampleAppmBackDrop", sampleApp.win.Main_Control, CT_BACKDROP)
  mBackDrop:SetCenterColor(0.1,0.1,0.1,1)
  mBackDrop:SetEdgeColor(1,1,1,0)
  mBackDrop:SetDimensions(50,50)

  mBackDrop:SetEdgeTexture("", 8, 1, 1)
  mBackDrop:SetDrawLayer(1)
  mBackDrop:SetAnchor(0,sampleApp.win.Main_Control,BOTTOMLEFT, LEFT - 50, BOTTOM - 250)

--- Made Global to we can update FPS inside of OnUpdate
  BGLabelz = sampleApp.win.wm:CreateControl("BGLabel", mBackDrop, CT_LABEL)
  BGLabelz:SetFont("ZoFontGame")
  BGLabelz:SetColor(255, 255, 255, 1)
  BGLabelz:SetText("FPS:")
  BGLabelz:SetAnchor(0, mBackDrop, 0, LEFT, 20)



  ----- This is where we create the list element for Unicorn/ List
  sampleAppList = Unicorn.ListView.new(sampleApp.win.Main_Control, {
    width = 650,  --aka settings.width
    height = 500, -- aka settings.height
  })

  -- Top left warning icon.. to remind you to mail me goldz ;) or motifs lol.
  local ILoveGold = CreateControlFromVirtual(sampleApp.var.appName.. "SendMeGold" .. "WarningIcon", sampleApp.win.Main_Control, "ZO_Options_WarningIcon")
  ILoveGold:SetAnchor(0, sampleApp.win.Main_Control, 0, LEFT -20, -25)
  ILoveGold.tooltipText = "WARNINGS: THIS SAMPLE APPLICATION IS SUPER AWESOME. BECAREFUL and DONATE GOLD TO @Awesomebilly (NA) lol :)"




  -----------------------------------------------------------------------------------------------
  --These are the two buttons to refresh and close. Please note that "Refresh is localized"  ----
  -----------------------------------------------------------------------------------------------
  sampleApp.win.Main_Control.RefreshBtn = CreateControlFromVirtual("btnTotalRefresh", sampleApp.win.Main_Control, "ZO_DefaultButton")
  sampleApp.win.Main_Control.RefreshBtn:SetAnchor(BOTTOMLEFT, sampleApp.win.Main_Control, BOTTOMLEFT, 0, 30)
  sampleApp.win.Main_Control.RefreshBtn:SetWidth(100)
  sampleApp.win.Main_Control.RefreshBtn:SetText(SI.get(SI.REFRESH)) -- Using localization here.
  sampleApp.win.Main_Control.RefreshBtn:SetHandler("OnClicked", function() RefreshGuildList()end)  -- this is the method to call once clicked


  sampleApp.win.Main_Control.CloseBtn = CreateControlFromVirtual("CloseBtn", sampleApp.win.Main_Control, "ZO_DefaultButton")
  sampleApp.win.Main_Control.CloseBtn:SetAnchor(BOTTOMRIGHT, sampleApp.win.Main_Control, BOTTOMRIGHT, 0, 30)
  sampleApp.win.Main_Control.CloseBtn:SetWidth(100)
  sampleApp.win.Main_Control.CloseBtn:SetText("CLOSE") -- Using localization here.
  sampleApp.win.Main_Control.CloseBtn:SetHandler("OnClicked", function() HideUIz()end)  -- this is the method to call once clicked

end







function SampleAppSetupUI(addOnName)
  if "SampleApp" ~= addOnName then return end
  SetupOptionsMenu(addOnName)
  SetupUI()  -- Future Release
end
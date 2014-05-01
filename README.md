SampleApp

=========

What does this app do?
----------------

This addon will show a few basic features that can be troublesum for new LUA addon developers.



How does it work?
-----------------
(Not necessarily in this order)
1. Example of Creating UI elements  -- Implemented
2. Example of using LibAddonMenu from @Seerah (Settings Menu)   -Implemented
3. Example of Saved Variables -Implemented
4. Global vs Local variables -Implemented
5. Using Events -Implemented
6. Localization -- Implemented
7. Example of Unicorn framework. --Implemented
8. Adding SLASHCOMMANDS -Implemented
9. OnAddonLoaded Example  -Implemented
10. OnUpdate Example  -Implemented



Changelog
---------

0.01 Inital Idea. 
Create basic framework for new developers to follow.


TODO / ideas
------------
9. Show example of overriding buttons


Notes:
--------------

Not everything I do is best practices, if you're more experienced in LUA than me, please feel free to contribute to this addon. 

Example:
ruby_variables_are_usually_like_this
javaVariablesAreCamelCased.
I prefer camelCasedVariables.




SampleApp.txt
## Title: SampleApp  --Name of your application. This needs to also be the actual file name

## Author: @awesomebilly
## APIVersion: 100003   -- if ESO API updates, and this doesn't update.. your addon will become out of date.
## SavedVariables: SampleApp_Saved_Variable   -- this is how to save variables between logout or /reloadui
## Version: 1.1   -- Version of your application
## OptionalDependsOn: LibAddonMenu-1.0, LibAnimation-1.0, LibStub.lua, Unicorn.lua, List.lua   --Varios libs this addon will use.

libs/Unicorn.lua   --  implemented. 
libs/List.lua   ---  implemented
libs/LibAddonMenu-1.0  --- Addonmenu 
libs/LibAnimation-1.0 --- Not implemented yet.
libs/LibStub.lua      -- Used with AddonMenu

SampleAppGlobals.lua    --- Notice I load my globals in .txt before the rest of the files. Not sure if this is best practices but it works for me.   try moving it to the bottom of the list.. see what happens.
core/SI.lua   -- Load SI before localizations
localization/$(language).lua  -- Depending on what the client is in, EN, FR, DE this file will be chosen.

core/SampleAppUI.lua
core/SampCommons.lua
core/SampleDebug.lua
core/SampleSlashCommands.lua
SampleApp.xml
SampleApp.lua  -- I like to load this last, since it has OnAddonLoaded event in it.

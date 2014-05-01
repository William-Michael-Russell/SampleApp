function CheckGuildMemeberStatus()
  ------ Variables
  local SampleTotalGuilds = GetNumGuilds()
  local SampleGetGuildName = {}

  --------------------------------------------------------------------------
  --- The first for loop will iterate through all guilds
  --  The second for loop will iterate through all members in that guild
  --  -----------------------------------------------------------------------

  -----for loop # 1
  for i = 0, SampleTotalGuilds do
    local totalGuildMembers = GetNumGuildMembers(GetGuildId(i))
    ---- For loop #2
    for j = 0, totalGuildMembers do

      --- We save everything to a local table/array named e
      local e = {}
      e.GuildName = GetGuildName(GetGuildId(i))
      e.GuildMember, e.GuildMemberNote, e.GuildMemberRankIndex, e.GuildMemberStatus, e.GuildMemberSecSince = GetGuildMemberInfo(GetGuildId(i), j)
      e.hasCharacter, e.characterName, e.zoneName, e.classType, e.alliance, e.level, e.veteranRank =  GetGuildMemberCharacterInfo(GetGuildId(i), j)
      e.GuildIndex = i


      if e.GuildMemberSecSince >= 1814400 then -- 3 weeks since last logged in
        --- If the member is been logged out for 3 weeks, we'll add him to the table/array SampleGetGuildName
        e.formattedPlayerTime = tonumber(string.format("%.4f", math.floor( e.GuildMemberSecSince / 7 / 24 / 60 / 60)))
        table.insert(SampleGetGuildName, e)
      end
    end

  end

  --------------------------------------------------
  ---- Inside List.lua will be overwhelming --------
  -- Try not to read into it much except where I played notes ---
  ----------------------------------------------------------------


  --- All members that have been logged out for longer than 3 weeks will be added to the list.
  sampleAppList:add_message(SampleGetGuildName)  -- this adds a message inside List.lua
end
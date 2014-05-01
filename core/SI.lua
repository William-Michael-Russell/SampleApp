local SI = {}

-------- --------------------------------------------------------------------
-- Each SI you create you need to register with it with ESO like below
-----------------------------------------------------------------------------
SI.WELCOMEMSG = "SI_WELCOMEMSG"
SI.REFRESH = "SI_SAMP_REFRESH"


-- utility functions
function SI.get(key, n)
    assert(key ~= nil)
    return assert(GetString(_G[key], n))
end


---- Your global sampleApp var from SampleApp.lua. We're setting it to SI here. 
sampleApp.SI = SI

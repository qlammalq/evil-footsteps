-- made by malq
-- defining cvars for the addon. using replicated flags so server/client stay in sync.
-- keeping these as cvars so they can be changed via console or the utility menu.

-- general toggles
CreateConVar("phantom_step_enabled", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "toggle the addon logic")
CreateConVar("phantom_step_chance", "100", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "chance of a sound triggering per cycle")
CreateConVar("phantom_step_min", "20", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "min interval for the timer")
CreateConVar("phantom_step_max", "60", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "max interval for the timer")

-- volume parameters
CreateConVar("phantom_step_vol_min", "0.3", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "minimum volume for sounds")
CreateConVar("phantom_step_vol_max", "0.8", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "maximum volume for sounds")

-- positioning 
CreateConVar("phantom_step_dist_start", "150", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "starting distence behind the player")
CreateConVar("phantom_step_spread", "40", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "horizontal variance in units")

-- burst logic for multiple steps
CreateConVar("phantom_step_burst_chance", "30", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "chance for a sequence of steps")
CreateConVar("phantom_step_burst_count", "4", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "max steps in a sequence")
CreateConVar("phantom_step_burst_speed", "0.25", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "delay between steps in a sequence")
CreateConVar("phantom_step_patter_towards", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "move sound toward the player over time")

-- debug
CreateConVar("phantom_step_debug", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "enable debug visualisation")
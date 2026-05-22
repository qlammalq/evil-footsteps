local function look(p, pos)
local v = p:GetAimVector()
local t = (pos - p:GetShootPos()):GetNormalized()
return v:Dot(t) > 0.6 
end

local function do_step(p, pos, vol)
if look(p, pos) then return false end
local tr = util.TraceLine({start = pos + Vector(0,0,30), endpos = pos - Vector(0,0,60), filter = p})
if tr.Hit then
local snd = util.GetSurfacePropName(tr.SurfaceProps) .. (math.random(1,2) == 1 and ".StepLeft" or ".StepRight")
sound.Play(snd, tr.HitPos, 75, math.random(90, 110), math.Clamp(vol, 0, 1))
if GetConVar("phantom_step_debug"):GetBool() then
debugoverlay.Box(tr.HitPos, Vector(-3,-3,-3), Vector(3,3,3), 5, Color(255,0,0))
end
return true
end
return false
end

local function run_stuff(p)
if not IsValid(p) or not p:Alive() then return end
if math.random(1,100) > GetConVar("phantom_step_chance"):GetInt() then return end
local b = math.random(1,100) <= GetConVar("phantom_step_burst_chance"):GetInt()
local cnt = b and math.random(2, GetConVar("phantom_step_burst_count"):GetInt()) or 1
local delay = GetConVar("phantom_step_burst_speed"):GetFloat()
local off = math.random(-GetConVar("phantom_step_spread"):GetFloat(), GetConVar("phantom_step_spread"):GetFloat())
local id = "b_" .. p:UserID() .. CurTime()
for i = 0, cnt - 1 do
timer.Create(id..i, i*delay, 1, function()
if not IsValid(p) then return end
local f = (cnt > 1) and (i / (cnt - 1)) or 1
local vol = GetConVar("phantom_step_patter_towards"):GetBool() and Lerp(f, GetConVar("phantom_step_vol_min"):GetFloat(), GetConVar("phantom_step_vol_max"):GetFloat()) or math.Rand(GetConVar("phantom_step_vol_min"):GetFloat(), GetConVar("phantom_step_vol_max"):GetFloat())
local dist = GetConVar("phantom_step_patter_towards"):GetBool() and Lerp(f, GetConVar("phantom_step_dist_start"):GetFloat(), 45) or GetConVar("phantom_step_dist_start"):GetFloat()
local ok = do_step(p, p:GetPos() - (p:GetForward()*dist) + (p:GetRight()*off), vol)
if not ok then
for k = i + 1, cnt - 1 do timer.Remove(id..k) end
end
end)
end
end

local function loop()
if GetConVar("phantom_step_enabled"):GetBool() then
for _, p in pairs(player.GetAll()) do run_stuff(p) end
end
timer.Simple(math.random(math.max(1, GetConVar("phantom_step_min"):GetFloat()), math.max(1, GetConVar("phantom_step_max"):GetFloat())), loop)
end
timer.Simple(10, loop)

concommand.Add("phantom_step_test", function(p)
if IsValid(p) and p:IsAdmin() then run_stuff(p) end
end)

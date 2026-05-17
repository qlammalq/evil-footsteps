-- made by malq
-- updated logic to support dsteps/eft footstep replacers.
-- using a temporary proxy entity to trigger lua sound hooks.

local function IsPlayerLookingAt(ply, targetPos)
    local aimVec = ply:GetAimVector()
    local toTarget = (targetPos - ply:GetShootPos()):GetNormalized()
    local dot = aimVec:Dot(toTarget)
    return dot > 0.6 
end

local function TriggerSingleStep(ply, pos, volume)
    if IsPlayerLookingAt(ply, pos) then return false end

    local tr = util.TraceLine({
        start = pos + Vector(0, 0, 30),
        endpos = pos - Vector(0, 0, 60),
        filter = ply
    })

    if tr.Hit then
        local surfaceName = util.GetSurfacePropName(tr.SurfaceProps)
        -- using the standard surface step scripts (e.g., "concrete.StepLeft")
        local soundScript = surfaceName .. (math.random(1,2) == 1 and ".StepLeft" or ".StepRight")
        local finalVol = math.Clamp(volume, 0, 1)
        
        -- seasoned nerd note: dsteps/eft mods hook into EntityEmitSound.
        -- sound.Play bypasses those hooks. we create a temporary proxy 
        -- entity at the hit position so those mods can "catch" the sound call.
        local proxy = ents.Create("info_target")
        proxy:SetPos(tr.HitPos)
        proxy:Spawn()
        
        -- we emit the sound from the proxy. the sound level 75 matches a normal walk.
        proxy:EmitSound(soundScript, 75, math.random(95, 105), finalVol, CHAN_BODY)
        
        -- cleanup the entity after the sound has likely finished playing.
        SafeRemoveEntityDelayed(proxy, 1)

        if GetConVar("phantom_step_debug"):GetBool() then
            debugoverlay.Box(tr.HitPos, Vector(-3,-3,-3), Vector(3,3,3), 5, Color(255, 0, 0))
            debugoverlay.Text(tr.HitPos, "PROXY EMIT: " .. soundScript, 5)
        end
        return true
    end
    return false
end

-- the rest of the script (ProcessPhantomStep, MainLoop, etc) stays the same.
-- i am including it here for a clean copy-paste.

local function ProcessPhantomStep(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    if math.random(1, 100) > GetConVar("phantom_step_chance"):GetInt() then return end

    local isBurst = math.random(1, 100) <= GetConVar("phantom_step_burst_chance"):GetInt()
    local stepCount = isBurst and math.random(2, GetConVar("phantom_step_burst_count"):GetInt()) or 1
    local delay = GetConVar("phantom_step_burst_speed"):GetFloat()
    local sideOffset = math.random(-GetConVar("phantom_step_spread"):GetFloat(), GetConVar("phantom_step_spread"):GetFloat())
    local burstID = "burst_" .. ply:UserID() .. "_" .. CurTime()

    for i = 0, stepCount - 1 do
        timer.Create(burstID .. i, i * delay, 1, function()
            if not IsValid(ply) then return end
            local fraction = (stepCount > 1) and (i / (stepCount - 1)) or 1
            local vol = GetConVar("phantom_step_patter_towards"):GetBool() and Lerp(fraction, GetConVar("phantom_step_vol_min"):GetFloat(), GetConVar("phantom_step_vol_max"):GetFloat()) or math.Rand(GetConVar("phantom_step_vol_min"):GetFloat(), GetConVar("phantom_step_vol_max"):GetFloat())
            local dist = GetConVar("phantom_step_patter_towards"):GetBool() and Lerp(fraction, GetConVar("phantom_step_dist_start"):GetFloat(), 45) or GetConVar("phantom_step_dist_start"):GetFloat()
            
            local success = TriggerSingleStep(ply, ply:GetPos() - (ply:GetForward() * dist) + (ply:GetRight() * sideOffset), vol)
            if not success then
                for k = i + 1, stepCount - 1 do timer.Remove(burstID .. k) end
            end
        end)
    end
end

local function MainLoop()
    if GetConVar("phantom_step_enabled"):GetBool() then
        for _, ply in ipairs(player.GetAll()) do ProcessPhantomStep(ply) end
    end
    timer.Simple(math.random(math.max(1, GetConVar("phantom_step_min"):GetFloat()), math.max(1, GetConVar("phantom_step_max"):GetFloat())), MainLoop)
end
timer.Simple(10, MainLoop)

concommand.Add("phantom_step_test", function(ply)
    if IsValid(ply) and ply:IsAdmin() then ProcessPhantomStep(ply) end
end)
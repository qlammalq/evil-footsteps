hook.Add("PopulateToolMenu", "menu_thingy", function()
spawnmenu.AddToolMenuOption("Utilities", "Horror", "settings_id", "Evil Footsteps", "", "", function(p)
p:ClearControls()
p:Help("malq made this")

p:Help("basic stuff")
p:CheckBox("turn it on", "phantom_step_enabled")
p:NumSlider("how likely", "phantom_step_chance", 0, 100, 0)
p:NumSlider("fastest wait", "phantom_step_min", 1, 120, 0)
p:NumSlider("slowest wait", "phantom_step_max", 1, 300, 0)

p:Help("how loud")
p:NumSlider("quietest", "phantom_step_vol_min", 0, 1, 2)
p:NumSlider("loudest", "phantom_step_vol_max", 0, 1, 2)
p:ControlHelp("random volume between these")

p:Help("where it starts")
p:NumSlider("how far back", "phantom_step_dist_start", 20, 500, 0)
p:NumSlider("how wide", "phantom_step_spread", 0, 200, 0)
p:ControlHelp("where the sound comes from")

p:Help("stuff that happens in a row")
p:NumSlider("chance for a group", "phantom_step_burst_chance", 0, 100, 0)
p:CheckBox("do they walk closer", "phantom_step_patter_towards")
p:NumSlider("how many steps", "phantom_step_burst_count", 2, 15, 0)
p:NumSlider("how fast steps go", "phantom_step_burst_speed", 0.05, 1, 2)

p:Help("testing")
p:CheckBox("see red boxes", "phantom_step_debug")

local b = p:Button("try it now")
b.DoClick = function() 
RunConsoleCommand("phantom_step_test") 
end
p:ControlHelp("press for test")
end)
end)

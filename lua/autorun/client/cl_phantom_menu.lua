-- made by malq
-- client side menu for evil footsteps behind you.mp4
-- hooks into the utilities tab to allow for real-time parameter adjustment.

hook.Add("PopulateToolMenu", "PhantomStepsMenu", function()
    spawnmenu.AddToolMenuOption("Utilities", "Horror", "EvilFootsteps_Settings", "Evil Footsteps", "", "", function(panel)
        panel:ClearControls()

        panel:Help("made by malq")

        -- main logic settings
        panel:Help("general logic configuration")
        panel:CheckBox("enable addon", "phantom_step_enabled")
        panel:NumSlider("activation probability", "phantom_step_chance", 0, 100, 0)
        panel:NumSlider("min interval", "phantom_step_min", 1, 120, 0)
        panel:NumSlider("max interval", "phantom_step_max", 1, 300, 0)

        -- gain/volume controls
        panel:Help("volume levels")
        panel:NumSlider("minimum volume", "phantom_step_vol_min", 0, 1, 2)
        panel:NumSlider("maximum volume", "phantom_step_vol_max", 0, 1, 2)
        panel:ControlHelp("volume is randomized between these values per step.")

        -- spatial positioning
        panel:Help("spatial positioning")
        panel:NumSlider("start distance", "phantom_step_dist_start", 20, 500, 0)
        panel:NumSlider("horizontal spread", "phantom_step_spread", 0, 200, 0)
        panel:ControlHelp("how far back and to the side the sounds originate.")

        -- burst/patter logic
        panel:Help("sequence behavior")
        panel:NumSlider("sequence chance", "phantom_step_burst_chance", 0, 100, 0)
        panel:CheckBox("lerp toward player", "phantom_step_patter_towards")
        panel:NumSlider("sequence count", "phantom_step_burst_count", 2, 15, 0)
        panel:NumSlider("sequence delay", "phantom_step_burst_speed", 0.05, 1, 2)

        -- debugging and manual testing
        panel:Help("system tools")
        panel:CheckBox("enable debug boxes", "phantom_step_debug")
        
        local btn = panel:Button("test current settings")
        btn.DoClick = function() 
            RunConsoleCommand("phantom_step_test") 
        end
        panel:ControlHelp("triggers a sequence immediately for admin verification.")

    end)
end)
--[[_________  ___  ___  ________  ________   ___  __             ___    ___ ________  ___  ___          ________  ___  _____ ______   ___  ________  ___  ___     
|\___   ___\\  \|\  \|\   __  \|\   ___  \|\  \|\  \          |\  \  /  /|\   __  \|\  \|\  \        |\   __  \|\  \|\   _ \  _   \|\  \|\   __  \|\  \|\  \    
\|___ \  \_\ \  \\\  \ \  \|\  \ \  \\ \  \ \  \/  /|_        \ \  \/  / | \  \|\  \ \  \\\  \       \ \  \|\  \ \  \ \  \\\__\ \  \ \  \ \  \|\  \ \  \\\  \   
     \ \  \ \ \   __  \ \   __  \ \  \\ \  \ \   ___  \        \ \    / / \ \  \\\  \ \  \\\  \       \ \   _  _\ \  \ \  \\|__| \  \ \  \ \   _  _\ \  \\\  \  
      \ \  \ \ \  \ \  \ \  \ \  \ \  \\ \  \ \  \\ \  \        \/  /  /   \ \  \\\  \ \  \\\  \       \ \  \\  \\ \  \ \  \    \ \  \ \  \ \  \\  \\ \  \\\  \ 
       \ \__\ \ \__\ \__\ \__\ \__\ \__\\ \__\ \__\\ \__\     __/  / /      \ \_______\ \_______\       \ \__\\ _\\ \__\ \__\    \ \__\ \__\ \__\\ _\\ \_______\
        \|__|  \|__|\|__|\|__|\|__|\|__| \|__|\|__| \|__|    |\___/ /        \|_______|\|_______|        \|__|\|__|\|__|\|__|     \|__|\|__|\|__|\|__|\|_______|
                                                             \|___|/                                                                                            
]]




--gets the MP number by hashing the last multiplayer character (0, 1, 2, etc.)
function getMP()
    MP_index = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
--makes the output a string
    return tostring(MP_index)
end
--adds "MP" before the number to get MP0, MP1, etc.
local localPlayerMP = "MP" .. getMP()
print(localPlayerMP)
--the default command gotten from UNKNOWNCHEATS:
--stats.stat_set_float(gameplay.get_hash_key(localPlayerMP .. "_PLAYER_MENTAL_STATE"), 100.0, true)

--checks for trusted mode
if not menu.is_trusted_mode_enabled() then
    menu.notify("Please enable trusted mode!")
end

if menu.is_trusted_mode_enabled() then
    ui.notify_above_map("You're good to go!", "", 0)
end


--sets the parent, or folder, that it's going to be in
local setMS = menu.add_feature("Simple Mental State", "parent", 0)


--full mental state trigger
menu.add_feature("Full Mental State", "action", setMS.id, function()
    --prints to debug console
    print(localPlayerMP .. "_PLAYER_MENTAL_STATE")
    --actual set stat for mental state
    stats.stat_set_float(gameplay.get_hash_key(localPlayerMP .. "_PLAYER_MENTAL_STATE"), 100.0, true)
    ui.notify_above_map("~h~" .. "~r~" .. "Mental State Full!" .. "~r~" .. "~h~", "Simple Mental State", 0)
    ui.notify_above_map("You will have to rejoin/switch sessions for it to apply!", "Simple Mental State", 0)
end)


menu.add_feature("Emtpy Mental State", "action", setMS.id, function()
    --prints to debug console
    print(localPlayerMP .. "_PLAYER_MENTAL_STATE")
    --actual set stat for mental state
    stats.stat_set_float(gameplay.get_hash_key(localPlayerMP .. "_PLAYER_MENTAL_STATE"), 0.0, true)
    ui.notify_above_map("~h~" .. "~g~" .. "Mental State Full!" .. "~g~" .. "~h~", "Simple Mental State", 0)
    ui.notify_above_map("You will have to rejoin/switch sessions for it to apply!", "Simple Mental State", 0)
end)



--set a custom mental state by using action_value_f, because for some fucking reason the mental state
--is a float, not an integer. GTA spaghetti.
local valueToSet = menu.add_feature("Mental State (from 0 - 100)", "action_value_f", setMS.id, function(val)
    --prints to debug console
    print(val.value)
    --actual set stat for mental state
    print(stats.stat_set_float(gameplay.get_hash_key(localPlayerMP .. "_PLAYER_MENTAL_STATE"), val.value, true))
    ui.notify_above_map("Mental State Set to " .. "~h~" .. "~y~" ..  val.value .. "~y~".. "~h~", "Simple Mental State", 0)
    ui.notify_above_map("You will have to rejoin/switch sessions for it to apply!", "Simple Mental State", 0)
end)
--min and max values for the float for mental state
valueToSet.max = 100
valueToSet.min = 0
valueToSet.value = 0
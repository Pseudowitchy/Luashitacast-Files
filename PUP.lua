local profile = {};
includes = gFunc.LoadFile('includes.lua');

tTimers = true; -- Do you use TTimers addon? Tracks avatar buff durations into the Custom timers section.

macroBook = 1;
macroSet  = 1; -- Page within book
lockstyleSet = 196; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = '';
util2     = '';

local sets = {
    Idle = {
        range = "",
        ammo  = "",
        head  = "",
        neck  = "",
        ear1  = "",
        ear2  = "",
        body  = "",
        hands = "",
        ring1 = "",
        ring2 = "",
        back  = "",
        waist = "",
        legs  = "",
        feet  = ""
    },

        -- TP Gearsets decided by player/auto status as well as DamageMode setting 
        -- Standard, Acc, Fodder for accuracy/damage focus depending on content decided based on AccMode setting

    TP_Master_Standard = { -- Master fighting, Automaton idle/non-existant
    
    },

    TP_Master_Acc = {
    
    },

    TP_Master_Fodder = {
    
    },
    
    TP_MasterAuto_Standard = { -- Both Master/Auto fighting
    
    },

    TP_MasterAuto_Acc = {
    
    },

    TP_MasterAuto_Fodder = {
    
    },
    
    TP_Auto_Standard = { -- Master idle, Pet engaged
    
    },

    TP_Auto_Acc = {
    
    },

    TP_Auto_Fodder = {
    
    },
    
    WS = { -- Default WS

    },

    StringingPummel = {

    },

    Repair = {
    
    },
    
--###########################################################################################################
--######################################           PET  SETS           ######################################
--###########################################################################################################

    Auto_WS = {
    
    },
    
    Auto_Cure = {
    
    },
    
    Auto_Nuke = {
    
    },
    
    Auto_Enfeeble = {
    
    },
    
--###########################################################################################################
--######################################         MANEUVER SETS         ######################################
--###########################################################################################################

    Maneuver = { -- - Overload rate gear, (Buffoon's Collar, Pup. Dastanas) | Will OVERWRITE below sets
    
    },
    
    Maneuver_Fire = { -- STR > Automaton STR for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Thunder = { -- DEX > Automaton DEX for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Earth = { -- VIT > Automaton VIT for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Wind = { -- AGI > Automaton AGI for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Ice = { -- INT > Automaton INT for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Water = { -- MND > Automaton MND for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },

    Maneuver_Light = { -- CHR > Automaton CHR for reduced burden (15 burden if player > auto; 20 otherwise)
    
    },
    
    Maneuver_Dark = { -- MP > Automaton MP for reduced burden (10 burden if player > auto; 15 otherwise)
    
    },    

--###########################################################################################################
--######################################          MISC.  SETS          ######################################
--###########################################################################################################

    Precast = { -- Fast Cast

    },

    Midcast = { -- Spell Interruption Rate
        waist = "Heko Obi +1",
    },
    
    Resting = {

    },
    
    Town = {
        
    },

    Movement = {},
};

profile.Sets = sets;

local DamageModeTable = {  -- Determines who to prioritize while TPing, shared gear, master only, automaton only
    [0] = 'MasterAuto',
    [1] = 'Master',
    [2] = 'Automaton'
};

local AccModeTable = {  -- Determines who to prioritize while TPing, shared gear, master only, automaton only
    [0] = 'Standard',
    [1] = 'Acc',
    [2] = 'Fodder'
};

local ManeuverTable = {  -- Determines who to prioritize while TPing, shared gear, master only, automaton only
    [0] = 'Fire',
    [1] = 'Thunder',
    [2] = 'Earth',
    [3] = 'Wind',
    [4] = 'Ice',
    [5] = 'Water',
    [6] = 'Light',
    [7] = 'Dark'
};

local ManeuverSet = { -- Tracks last 3 tracked Maneuvers from above table
    [0] = 'None',
    [1] = 'None',
    [2] = 'None'
};

local Settings = { -- Default setting, change damage mode to match above for preference. Keybind to cycle in-game
    DamageMode = 0,
    AccMode = 0,
    Maneuver = 0,
    ManeuverSlot = 0
};

profile.OnLoad = function()
    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);

    AshitaCore:GetChatManager():QueueCommand(1, '/bind f11 /lac fwd DamageMode'); -- Cycle TP Priority
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f10 /lac fwd AccMode'); -- Cycle Acc Type
    AshitaCore:GetChatManager():QueueCommand(1, '/bind end /lac fwd ManFwd'); -- Cycle Selected Maneuver Forwards
    AshitaCore:GetChatManager():QueueCommand(1, '/bind delete /lac fwd ManBack'); -- Cycle Selected Maneuver Backwards
    AshitaCore:GetChatManager():QueueCommand(1, '/bind pagedown /lac fwd ManAdd'); -- Adds selected Maneuver to current Maneuver set

    includes.OnLoad();
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f11');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f10');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind end');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind delete');  
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind pagedown');  

    includes.OnUnload();
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();

    if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
        
    if (player.Status == 'Engaged') then
        if (pet == nil) then
            gFunc.EquipSet(sets.TP_Master);
        elseif (pet.Status == 'Idle') then
            gFunc.EquipSet(sets.TP_Master);            
        else
            gFunc.EquipSet('TP_' .. DamageModeTable[Settings.DamageMode] .. '_' .. AccModeTable[Settings.AccMode]);
        end
    end
    
    if (player.Status == 'Idle') then
        if (pet == nil) then
            gFunc.EquipSet(sets.Idle);
        elseif (pet.Status == 'Idle') then
            gFunc.EquipSet(sets.Idle);
        elseif (pet.Status == 'Engaged' and (Settings.DamageMode ~= 'Master')) then
            gFunc.EquipSet(sets.TP_Auto);
        end
    end
        
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
    
    includes.RestingCheck(player);
	includes.CheckDefaults();
    
    if (pet ~= nil) then
        if (pet.Status == 'Engaged' and pet.TP >= 800 and Settings.DamageMode ~= 'Master') then
            gFunc.EquipSet(sets.Auto_WS);
        end
    end
end

profile.HandleAbility = function()
	local ability = gData.GetAction();
    
    if (ability.Name == "Repair") then
        gFunc.EquipSet(sets.Repair);
    elseif string.contains(ability.Name, "Maneuver") then    
        if (ability.Name == 'Fire Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Fire);
        elseif (ability.Name == 'Thunder Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Thunder);
        elseif (ability.Name == 'Earth Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Earth);
        elseif (ability.Name == 'Wind Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Wind);
        elseif (ability.Name == 'Ice Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Ice);
        elseif (ability.Name == 'Water Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Water);
        elseif (ability.Name == 'Light Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Light);
        elseif (ability.Name == 'Dark Maneuver') then
            gFunc.EquipSet(sets.Maneuver_Dark);
        end
        gFunc.EquipSet(sets.Maneuver);
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
 
    gFunc.EquipSet(sets.WS);
 
    if (action.Name == "Stringing Pummel") then
        gFunc.EquipSet(sets.StringingPummel);
    end    
end

local function HandlePetAction(PetAction)
	if (PetAction.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Auto_Cure);
	elseif (PetAction.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Auto_Nuke);
    elseif (PetAction.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Auto_Nuke);
	elseif (PetAction.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Auto_Enfeeble);
    end

    if (tTimers) then
        if (PetAction.Name == 'Provoke') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Strobe" 30');
        elseif (PetAction.Name == 'Reactive Shield') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Reactive Shield" 65');
        elseif (PetAction.Name == 'Barrage') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Barrage Turbine" 180');
        elseif (PetAction.Name == 'Stoneskin') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Shock Absorber" 180');
        elseif (PetAction.Name == 'Reactive Shield') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Reactive Shield" 65');
        elseif (PetAction.Name == 'Flash') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Flashbulb" 45');
        elseif (PetAction.Name == 'Erase') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Eraser" 30');
        elseif (PetAction.Name == 'Convert') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Mana Converter" 180');
        elseif (PetAction.Name == 'Economizer') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Economizer" 180');
        elseif (PetAction.Name == 'Dispel') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Disruptor" 60');
        elseif (PetAction.Name == 'Regulator') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Regulator" 60');
        end
    end
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.Midcast);
end

profile.HandleCommand = function(args)
    if (args[1] == 'DamageMode') then
        Settings.DamageMode = Settings.DamageMode + 1;
        if (Settings.DamageMode > #DamageModeTable) then
            Settings.DamageMode = 0;
        end
        includes.echoToChat('TP Set Preference: ', DamageModeTable[Settings.DamageMode]);
    elseif (args[1] == 'AccMode') then
        Settings.AccMode = Settings.AccMode + 1;
        if (Settings.AccMode > #AccModeTable) then
            Settings.AccMode = 0;
        end
        includes.echoToChat('Accuracy Preference: ', AccModeTable[Settings.AccMode]);
    elseif (args[1] == 'ManFwd') then
        Settings.Maneuver = Settings.Maneuver + 1;
        if (Settings.Maneuver > #ManeuverTable) then
            Settings.Maneuver = 0;
        end
        includes.echoToChat('Selected Maneuver: ', ManeuverTable[Settings.Maneuver]);
    elseif (args[1] == 'ManBack') then
        Settings.Maneuver = Settings.Maneuver - 1;
        if (Settings.Maneuver < 0) then
            Settings.Maneuver = #ManeuverTable;
        end
        includes.echoToChat('Selected Maneuver: ', ManeuverTable[Settings.Maneuver]);
    elseif (args[1] == 'ManAdd') then
        ManAdd();
    elseif (args[1] == 'ManUse') then
        ManUse();
    else includes.HandleCommands(args);
    end    
end

function ManAdd()
    ManeuverSet[2] = ManeuverSet[1];
    ManeuverSet[1] = ManeuverSet[0];
    ManeuverSet[0] = ManeuverTable[Settings.Maneuver];
    
    local ManeuverString = ManeuverSet[0];
    if (ManeuverSet[2] ~= 'None') then
        ManeuverString = ManeuverString .. ' ' .. ManeuverSet[1] .. ' ' .. ManeuverSet[2];         
    elseif (ManeuverSet[1] ~= 'None') then
        ManeuverString = ManeuverString .. ' ' .. ManeuverSet[1];
    end
    
    includes.echoToChat(ManeuverSet[0], ' added to Maneuver Set.');
    includes.echoToChat('Current Maneuver Set: ', ManeuverString);

    if (Settings.ManeuverSlot < 2) then
        Settings.ManeuverSlot = Settings.ManeuverSlot + 1;
    end
end

function ManUse()
    local pet = gData.GetPet();
    local maneuverCD = 0;

    if (pet ~= nil) then
        for x = 0, 31 do -- This loop searches player abilities to find any off cooldown, and then checks if 'Maneuver' is part of the name~
            local id = AshitaCore:GetMemoryManager():GetRecast():GetAbilityTimerId(x);
            local timer = AshitaCore:GetMemoryManager():GetRecast():GetAbilityTimer(x);
            
            if ((id ~= 0) and timer > 0) then
                local ability = AshitaCore:GetResourceManager():GetAbilityByTimerId(id)
                if (ability ~= nil) then
                    if (string.contains(ability.Name[1], 'Maneuver')) then
                        maneuverCD = timer;
                        break
                    end
                end
            end
        end

        if (maneuverCD == 0) then
            if (ManeuverSet[0] == 'None' and ManeuverSet[1] == 'None' and ManeuverSet[2] == 'None') then
                AshitaCore:GetChatManager():QueueCommand(1, '/echo No Maneuver Set defined, use \'ManAdd\' to add maneuvers to the set.');
                return
            elseif (ManeuverSet[Settings.ManeuverSlot] == 'None') then
                if (ManeuverSet[Settings.ManeuverSlot - 1] == 'None') then
                    ManeuverSet[Settings.ManeuverSlot] = ManeuverSet[Settings.ManeuverSlot - 2]; 
                    Settings.ManeuverSlot = Settings.ManeuverSlot - 2;
                else 
                    ManeuverSet[Settings.ManeuverSlot] = ManeuverSet[Settings.ManeuverSlot - 1]; 
                    Settings.ManeuverSlot = Settings.ManeuverSlot - 1;
                end
            end

            AshitaCore:GetChatManager():QueueCommand(1, '/ja "' .. ManeuverSet[Settings.ManeuverSlot] .. ' Maneuver" <me>'); 
            
            Settings.ManeuverSlot = Settings.ManeuverSlot - 1;
            if (Settings.ManeuverSlot < 0) then
                Settings.ManeuverSlot = #ManeuverSet;
            end
        else
            includes.echoToChat('Maneuvers on cooldown. ', '');
        end
    else
        includes.echoToChat('No active pet. ', 'Please activate your Automaton.')
        return
    end
end

return profile;
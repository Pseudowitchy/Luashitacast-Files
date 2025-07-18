local profile = {};
includes = gFunc.LoadFile('includes.lua');
display = gFunc.LoadFile('display.lua');

tTimers = true; -- Do you use TTimers addon? Tracks avatar buff durations into the Custom timers section.

macroBook = 1;
macroSet  = 1; -- Page within book
lockstyleSet = 196; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = '';
util2     = '';

maneuvers = T{ 'dark', 'light', 'fire', 'water', 'thunder', 'earth', 'wind', 'ice' };
jobText = 'Maneuvers:';

local sets = {
    Idle = {
        -- range = "",
        -- ammo  = "",
        -- head  = "",
        -- neck  = "",
        -- ear1  = "",
        -- ear2  = "",
        -- body  = "",
        -- hands = "",
        -- ring1 = "",
        -- ring2 = "",
        -- back  = "",
        -- waist = "",
        -- legs  = "",
        -- feet  = ""
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

    Combo = { -- 20% STR 20% DEX

    },

    RagingFists = { -- 20% STR 20% DEX

    },

    HowlingFist = { -- 50% STR 20% VIT

    },

    DragonKick = { -- 50% STR 50% VIT

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

    AshitaCore:GetChatManager():QueueCommand(1, '/alias /man /lac fwd manadd'); -- add maneuvers to queue: /man fire earth thunder
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /manuse /lac fwd manuse'); -- use next manuever in queue

    AshitaCore:GetChatManager():QueueCommand(1, '/bind f11 /lac fwd DamageMode'); -- Cycle TP Priority
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f10 /lac fwd AccMode'); -- Cycle Acc Type

    includes.OnLoad();

    display.Load();
    display.CreateCycle('Damage Mode', {[1] = 'MasterAuto', [2] = 'Master', [3] = 'Automaton' });
    display.CreateCycle('Acc Mode', {[1] = 'Standard', [2] = 'Acc', [3] = 'Fodder' });
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /man');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /manuse');

    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f11');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f10');

    display.Unload();
    includes.OnUnload();
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local playerAction = gData.GetAction();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local zone = gData.GetEnvironment();

    if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
        
    if (player.Status == 'Engaged') then
        if (pet == nil or pet.Status == 'Idle') then
            gFunc.EquipSet('TP_Master_' .. display.GetCycle('Acc Mode'));         
        else
            gFunc.EquipSet('TP_' .. display.GetCycle('Damage Mode') .. '_' .. display.GetCycle('Acc Mode'));
        end

        if (player.MainJobSync >= 70 and (zone.Time > 6 and zone.Time < 18)) then
            gFunc.Equip(ear2, "Fenrir's Earring");
        end

        if (playerAction == nil) then
            manualManeuver = true;
        end
    end
    
    if (player.Status == 'Idle') then
        if (pet == nil or pet.Status == 'Idle') then
            gFunc.EquipSet(sets.Idle);
        elseif (pet.Status == 'Engaged' and (Settings.DamageMode ~= 'Master')) then
            gFunc.EquipSet('TP_Auto_' .. display.GetCycle('Acc Mode'));
        end

        if (playerAction == nil) then
            manualManeuver = true;
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

        if (manualManeuver == true) then
            manElement = playerAction.Name; -- this may or may not work, who knows? :3 defines manElement by its
            manElement = match("^([%w]+)"); -- first word in the string to then send to ManAdd function.
            ManAdd(manElement);
        end
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local zone = gData.GetEnvironment();
    gFunc.EquipSet(sets.WS);

    if (action.Name == "Combo") then
        gFunc.EquipSet(sets.Combo);
    elseif (action.Name == "Raging Fists") then
        gFunc.EquipSet(sets.RagingFists);
    elseif (action.Name == "Howling Fist") then
        gFunc.EquipSet(sets.HowlingFist);
    elseif (action.Name == "Dragon Kick") then
        gFunc.EquipSet(sets.DragonKick);
    elseif (action.Name == "Stringing Pummel") then
        gFunc.EquipSet(sets.StringingPummel);
    end    

    if (player.MainJobSync >= 70 and (zone.Time > 6 and zone.Time < 18)) then
        gFunc.Equip(ear2, "Fenrir's Earring");
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

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
    includes.HandleMidcast();
end

profile.HandleCommand = function(args)
    if (args[1] == 'DamageMode') then
        display.AdvanceCycle('Damage Mode');
    elseif (args[1] == 'AccMode') then
        display.AdvanceCycle('Acc Mode');
    elseif (string.lower(args[1]) == 'manadd') then
        local textError = false;
        if (args[4] ~= nil) then
            if (maneuvers:contains(string.lower(args[2])) and maneuvers:contains(string.lower(args[3])) and maneuvers:contains(string.lower(args[4]))) then
                ManAdd(string.lower(args[2]), string.lower(args[3]), string.lower(args[4]));
            else textError = true;
            end
        elseif (args[3] ~= nil) then
            if (maneuvers:contains(string.lower(args[2])) and maneuvers:contains(string.lower(args[3]))) then
                ManAdd(string.lower(args[2]), string.lower(args[3]));
            else textError = true;
            end
        elseif (args[2] ~= nil) then
            if (maneuvers:contains(string.lower(args[2]))) then
                ManAdd(string.lower(args[2]));
            else textError = true;
            end
        end
        if (textError) then
            includes.echoToChat('Invalid maneuvers. Ensure spelling is correct (case does not matter.) ex: /man Fire fire wind')
            return;
        end
    elseif (args[1] == 'manuse') then
        ManUse();
    else includes.HandleCommands(args);
    end
end

function ManAdd(manOne, manTwo, manThree)        
    if (manThree ~= nil) then
        ManeuverSet[2] = manThree;
        ManeuverSet[1] = manTwo;
        ManeuverSet[0] = manOne;
    elseif (manTwo ~= nil) then
        ManeuverSet[2] = ManeuverSet[0];
        ManeuverSet[1] = manTwo;
        ManeuverSet[0] = manOne;
    else
        ManeuverSet[2] = ManeuverSet[1];
        ManeuverSet[1] = ManeuverSet[0];
        ManeuverSet[0] = manOne;
    end
    
    jobText = 'Maneuvers:';
    for x = 0, 2 do
        if (ManeuverSet[x] ~= 'None') then
            jobText = jobText .. ' ' .. includes.elementColors[ManeuverSet[x]];
        end
    end
end

manualManeuver = true;
function ManUse()
    local pet = gData.GetPet();
    local maneuverCD = 0;
    manualManeuver = false;

     if (pet ~= nil) then
        for x = 0, 31 do
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
            local usedManeuver = ManeuverSet[0];
            local capElement = string.upper(string.sub(ManeuverSet[0], 1, 1)) .. string.lower(string.sub(ManeuverSet[0], 2, -1));
         
            if (ManeuverSet[0] == 'None') then
                AshitaCore:GetChatManager():QueueCommand(1, '/echo No Maneuvers defined, use \'/man (fire dark earth)\' to add maneuvers to the queue.');
                return;
            end

            AshitaCore:GetChatManager():QueueCommand(1, '/echo /ja "' .. capElement .. ' Maneuver" <me>'); 

            if (ManeuverSet[2] ~= 'None') then
                ManeuverSet[0] = ManeuverSet[1]; 
                ManeuverSet[1] = ManeuverSet[2];
                ManeuverSet[2] = usedManeuver;
            elseif (ManeuverSet[1] ~= 'None') then
                ManeuverSet[0] = ManeuverSet[1]; 
                ManeuverSet[1] = usedManeuver;
            end
        else
            includes.echoToChat('Maneuvers on cooldown.');
        end
    else
        includes.echoToChat('No active pet. Please activate your Automaton.')
        return
    end

    jobText = 'Maneuvers:';
    for x = 0, 2 do
        if (ManeuverSet[x] ~= 'None') then
            jobText = jobText .. ' ' .. includes.elementColors[ManeuverSet[x]];
        end
    end
end

return profile;
-- Kyo needs to add sets: Idle_PDT, Idle_MDT, TP_PDT, TP_MDT, Midcast_Enmity

local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 18;
macroSet  = 2; -- Page within book
lockstyleSet = 196; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = '';
util2     = '';

offenseMode = true; -- true = melee mode, false allows staves to be equipped
defenseMode = 0; -- Normal = 0, PDT = 1, MDT = 2

local sets = {
    Idle = {
        
    },

    Idle_PDT = {
        
    },

    Idle_MDT = {
        
    },

    TP = {

    },
    
    TP_PDT = {

    },
    
    TP_MDT = {

    },

    WS = {

    },

    WS_SpiritTaker = {}, -- add WS specific sets here

    Provoke = { -- Enmity gear

    },

    Resting = {

    },
    
    Precast = { -- Fast Cast
    
    },
    
    Midcast = { -- Spell Interruption Rate

    },

    Midcast_Wheel = { -- Elemental Wheel gear, INT, MAB Etc

    },

    Midcast_Enmity = { -- Only used for Hojo/Kurayami Ichi/Ni

    },
    
    Town = {},

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);
    
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f10 /lac fwd Offense');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f11 /lac fwd Defense');
    
    includes.OnLoad();
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f10');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f11');

    includes.OnUnload();
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
    if (player.Status == 'Engaged') then
        if (defenseMode == 0) then
            gFunc.EquipSet(sets.TP);
        elseif (defenseMode == 1) then
            gFunc.EquipSet(sets.TP_PDT)
        else
            gFunc.EquipSet(sets.TP_MDT)
        end
    else
        if (defenseMode == 0) then
            gFunc.EquipSet(sets.Idle);
        elseif (defenseMode == 1) then
            gFunc.EquipSet(sets.Idle_PDT)
        else
            gFunc.EquipSet(sets.Idle_MDT)
        end
    end

	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
    
    includes.RestingCheck(player);
	includes.CheckDefaults();
end
    
profile.HandlePrecast = function()
    gFunc.EquipSet(sets.Precast);
end

wheelSpells = T{ "Katon: Ichi", "Katon: Ni", "Hyoton: Ichi", "Hyoton: Ni",
                 "Huton: Ichi", "Huton: Ni", "Doton: Ichi", "Doton: Ni", 
                 "Raiton: Ichi", "Raiton: Ni", "Suiton: Ichi", "Suiton: Ni" };
enmitySpells = T{ "Kurayami: Ichi", "Kurayami: Ni", "Hojo: Ichi", "Hojo: Ni" };

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (offenseMode == true) then 
        gFunc.Equip(main,"");
        gFunc.Equip(sub,"");
    end
    
    if (wheelSpells:contains(spell.Name)) then
        gFunc.EquipSet(sets.Midcast_Wheel);
    elseif (enmitySpells:contains(spell.Name)) then
        gFunc.EquipSet(sets.Midcast_Enmity)
    end

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
    includes.HandleMidcast();
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Provoke') then
        gFunc.EquipSet(sets.Provoke);
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
 
    gFunc.EquipSet(sets.WS);
 
    if (action.Name == "Spirit Taker") then
        gFunc.EquipSet(sets.SpiritTaker);
    end    
end

profile.HandleCommand = function(args)
    if (args[1] == 'Offense') then
        offenseMode = not offenseMode;
        if (offenseMode == true) then
            includes.echoToChat("Combat Mode set to: Melee");
        else includes.echoToChat("Combat Mode set to: Staves");
        end
    elseif (args[1] == 'Defense') then 
        defenseMode = defenseMode + 1;
        if (defenseMode > 2) then defenseMode = 0; end
        if (defenseMode == 0) then
            includes.echoToChat("Defense Mode set to: Normal");
        elseif (defenseMode == 1) then
            includes.echoToChat("Defense Mode set to: PDT");
        elseif (defenseMode == 2) then
            includes.echoToChat("Defense Mode set to: MDT");
        end
    end

    includes.HandleCommands(args);
end

return profile;
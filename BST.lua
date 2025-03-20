local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 18;
macroSet  = 1; -- Page within book
lockstyleSet = 195; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = '';
util2     = '';

local sets = {
    Idle_WHM_Priority = {
        ammo  = "Pebble",
        head  = { "Beetle Mask +1", "Brass Cap" },
        neck  = "Spike Necklace",
        ear1  = { "Beetle Earring +1", "Bone Earring +1" },
        ear2  = { "Beetle Earring +1", "Bone Earring +1" },
        body  = { "Beetle Harness +1" },
        hands = { "Battle Gloves", "Republic Mittens" },
        ring1 = { "Courage Ring" },
        ring2 = { "Courage Ring" },
        back  = { "Traveler's Mantle" },
        waist = { "Leather Belt" },
        legs  = { "Beetle Subligar +1" },
        feet  = { "Btl. Leggings +1" }
    },

    Idle_NIN_Priority = {
        ammo  = "Pebble",
        head  = { "Beetle Mask +1", "Brass Cap" },
        neck  = "Spike Necklace",
        ear1  = { "Beetle Earring +1", "Bone Earring +1" },
        ear2  = { "Beetle Earring +1", "Bone Earring +1" },
        body  = { "Beetle Harness +1" },
        hands = { "Battle Gloves", "Republic Mittens" },
        ring1 = { "Courage Ring" },
        ring2 = { "Courage Ring" },
        back  = { "Traveler's Mantle" },
        waist = { "Leather Belt" },
        legs  = { "Beetle Subligar +1" },
        feet  = { "Btl. Leggings +1" }
    },

    TP_WHM_Priority = {
        ammo  = "Pebble",
        head  = { "Beetle Mask +1", "Brass Cap" },
        neck  = "Spike Necklace",
        ear1  = { "Beetle Earring +1", "Bone Earring +1" },
        ear2  = { "Beetle Earring +1", "Bone Earring +1" },
        body  = { "Beetle Harness +1" },
        hands = { "Battle Gloves", "Republic Mittens" },
        ring1 = { "Courage Ring" },
        ring2 = { "Courage Ring" },
        back  = { "Traveler's Mantle" },
        waist = { "Leather Belt" },
        legs  = { "Beetle Subligar +1" },
        feet  = { "Btl. Leggings +1" }
    },

    TP_NIN_Priority = {
        ammo  = "Pebble",
        head  = { "Beetle Mask +1", "Brass Cap" },
        neck  = "Spike Necklace",
        ear1  = { "Beetle Earring +1", "Bone Earring +1" },
        ear2  = { "Beetle Earring +1", "Bone Earring +1" },
        body  = { "Beetle Harness +1" },
        hands = { "Battle Gloves", "Republic Mittens" },
        ring1 = { "Courage Ring" },
        ring2 = { "Courage Ring" },
        back  = { "Traveler's Mantle" },
        waist = { "Leather Belt" },
        legs  = { "Beetle Subligar +1" },
        feet  = { "Btl. Leggings +1" }
    },
    
    WS = {
        hands = { "Republic Mittens" },
    },

    WS_SpiritTaker = {}, -- add WS specific sets here

    Charm = {
        head  = "Noble's Ribbon",
        neck  = "Bird Whistle",
        ring1 = "Hope Ring",
        ring2 = "Hope Ring",
    },

    Tame = {

    },

    Reward = {

    },
    
    Precast = { -- Fast Cast
    
    },

    Midcast = { -- Spell Interruption Rate

    },

    Resting = {

    },

    Town = {},

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);
        
    includes.OnLoad();
end

profile.OnUnload = function()
    includes.OnUnload();
end

local CurrentLevel = 0;
profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
    if (player.MainJobSync ~= CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, player.MainJobSync);
        CurrentLevel = player.MainJobSync;
    end

    if (player.Status == 'Engaged') then
        if (player.SubJob == 'NIN') then
            gFunc.EquipSet(sets.TP_NIN);
        else 
            gFunc.EquipSet(sets.TP_WHM);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        if (player.SubJob == 'NIN') then
            gFunc.EquipSet(sets.Idle_NIN);
        else 
            gFunc.EquipSet(sets.Idle_WHM);
        end
    end

	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
    
	includes.CheckDefaults();
end
    
profile.HandlePrecast = function()
    gFunc.EquipSet(sets.Precast);
end
    
profile.HandleMidcast = function()
    gFunc.EquipSet(sets.Midcast);

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
    includes.HandleMidcast();
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Charm') then
        gFunc.EquipSet(sets.Charm);
    elseif (ability.Name == 'Tame') then
        gFunc.EquipSet(sets.Tame);
    elseif (ability.Name == 'Reward') then
        gFunc.EquipSet(sets.Reward);
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
    includes.HandleCommands(args);
end

return profile;
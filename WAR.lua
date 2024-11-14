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

local sets = {
    Idle = {
        ammo  = "Pebble",
        head  = "Beetle Mask +1",
        neck  = "Spike Necklace",
        ear1  = "Beetle Earring +1",
        ear2  = "Beetle Earring +1",
        body  = "Beetle Harness +1",
        hands = "Republic Mittens",
        ring1 = "Courage Ring",
        ring2 = "Courage Ring",
        back  = "Traveler's Mantle",
        waist = "Leather Belt",
        legs  = "Beetle Subligar +1",
        feet  = "Btl. Leggings +1"
    },

    TP = {
        head  = "Beetle Mask +1",
        neck  = "Spike Necklace",
        ear1  = "Beetle Earring +1",
        ear2  = "Beetle Earring +1",
        body  = "Beetle Harness +1",
        hands = "Republic Mittens",
        ring1 = "Courage Ring",
        ring2 = "Courage Ring",
        back  = "Traveler's Mantle",
        waist = "Leather Belt",
        legs  = "Beetle Subligar +1",
        feet  = "Btl. Leggings +1"
    },
    
    WS = {

    },

    WS_SpiritTaker = {}, -- add WS specific sets here

    Provoke = {

    },

    Resting = {

    },
    
    Precast = { -- Fast Cast
    
    },
    
    Midcast = { -- Spell Interruption Rate

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

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.TP);
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
		gFunc.EquipSet(sets.Idle);
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
    includes.HandleCommands(args);
end

return profile;
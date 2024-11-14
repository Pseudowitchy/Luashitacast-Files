local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 5;
macroSet  = 1; -- Page within book
lockstyleSet = 197; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Stoneskin';
util2     = 'Paralyna';

local sets = {
    Idle = {
        main  = EarthStaff,
    },
    
    Resting = {
        main  = DarkStaff,
    },
    
    Precast = { -- Fast Cast

    },

    Precast_Cure = {

    },
    
    Precast_Stoneskin = {

    },
    
    Midcast = { -- Spell Interruption Rate

    },
    
    Midcast_Cure = {

    },

    Midcast_Enfeebling = { -- INT based enfeebles

    },
    
    Midcast_Mnd_Enfeebling = { -- MND based enfeebles

    },
    
    Midcast_Divine = { -- Elemental 

    },

    Midcast_Elemental = {

    },
    
    Midcast_Dark = {

    },    
    
    Midcast_Enhancing = {

    },
    
    Midcast_Enhancing_Stoneskin = { -- MND+ & Enhancing Skill

    },
    
    TP = {

    },
       
    WS = {

    },
    
    Town = {

    },

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet);
    
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /stone /lac fwd stone');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /water /lac fwd water');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /aero /lac fwd aero');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /fire /lac fwd fire');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /blizzard /lac fwd blizzard');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /thunder /lac fwd thunder');
        
    includes.OnLoad();
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /stone');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /water');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /aero');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /fire');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /blizzard');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /thunder');
       
    includes.OnUnload();
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.TP);
    elseif (player.Status == 'Resting') then        
        if (player.MainJobSync < 51) then
            gFunc.Equip('main', "Pilgrim's Wand");                
        elseif (player.MainJobSync < 72) then
            gFunc.Equip('body', "Vermillion Cloak");
            gFunc.Equip('head', '');
        end
    else
		gFunc.EquipSet(sets.Idle);
    end

	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
    
    includes.RestingCheck(player);
	includes.CheckDefaults();
end
    
profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast);

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Precast_Enhancing);
        if string.contains(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Precast_Stoneskin);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Precast_Cure);
    end
end
    
profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (spell.Skill == 'Divine Magic') then
        gFunc.EquipSet(sets.Divine);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Midcast_Dark);
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Midcast_Elemental);
    elseif (spell.Skill == 'Enfeebling Magic') then
        if (string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') or string.contains(spell.Name, 'Silence')) then
            gFunc.EquipSet(sets.Midcast_Mnd_Enfeebling);
        else
            gFunc.EquipSet(sets.Midcast_Enfeebling);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Midcast_Cure);
    elseif (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Midcast_Enhancing);
        if (spell.Name == 'Stoneskin') then
            gFunc.EquipSet(sets.Midcast_Enhancing_Stoneskin);
        end    
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
    end

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS);
end

profile.HandleCommand = function(args)
     includes.HandleCommands(args);
end

return profile;
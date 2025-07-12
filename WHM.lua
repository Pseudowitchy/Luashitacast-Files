local profile = {};
includes = gFunc.LoadFile('includes.lua');
conquest = gFunc.LoadFile('conquest.lua');


macroBook = 6;
macroSet  = 1; -- Page within book
lockstyleSet = 196; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Blink';
util2     = 'Stoneskin';

local sets = {
    Idle_Priority = {
        main  = { EarthStaff, "Rose Wand +1", "Solid Wand" },
        sub   = { { "", Level = 51 }, "Frost Shield" },
        ammo  = { "Hedgehog Bomb", "Phantom Tathlum", "Sweet Sachet" },
        head  = { { "", Level = 59 }, "Healer's Cap", "Republic Circlet" },
        neck  = { "Ajari Necklace", "Promise Badge", "Justice Badge" },
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = { "Vermillion Cloak", "Nimbus Doublet" },
        hands = "Devotee's Mitts",
        ring1 = { "Serenity Ring", "Solace Ring" },
        ring2 = { "Serenity Ring", "Solace Ring" },
        back  = "Red Cape +1",
        waist = "Penitent's Rope",
        legs  = { "Crow Hose", "Baron's Slops" },
        feet  = { "Healer's Duckbills", "Seer's Pumps +1" }
    },
    
    Resting_Priority = {
        main  = { DarkStaff, "Pilgrim's Wand" },
        neck  = "Checkered Scarf",
        ear2  = "Magnetic Earring",
        body  = { "Errant Hpl.", "Vermillion Cloak", "Seer's Tunic +1" },
        waist = { "Hierarch Belt" },
        legs  = { "Baron's Slops" },
    },
    
    Precast = { -- Fast Cast

    },

    Precast_Cure = {

    },
    
    Precast_Stoneskin = {

    },
    
    Midcast = { -- Spell Interruption Rate
        waist = "Swift Belt",
        feet  = "Healer's Duckbills"
    },
    
    Midcast_Cure = {
        hands = "Healer's Mitts",
        waist = "Swift Belt",
        feet  = "Healer's Duckbills"
    },

    Midcast_Enfeebling_Priority = { -- INT based enfeebles
        head  = "Seer's Crown +1",
        neck  = "Black Neckerchief",
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = { "Healer's Bliaut", "Ryl.Sqr. Robe +2" },
        hands = "Seer's Mitts +1",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Swift Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Healer's Duckbills"
    },
    
    Midcast_Enfeebling_Mnd_Priority = { -- MND based enfeebles
        head  = { "Healer's Cap", "Republic Circlet" },
        neck  = { "Ajari Necklace", "Promise Badge", "Justice Badge" },
        body  = { "Healer's Bliaut", "Ryl.Sqr. Robe +2" },
        hands = "Devotee's Mitts",
        ring1 = { "Serenity Ring", "Solace Ring" },
        ring2 = { "Serenity Ring", "Solace Ring" },
        back  = "Red Cape +1",
        waist = "Penitent's Rope",
        feet  = "Healer's Duckbills"
    },
    
    Midcast_Divine_Priority = {
        head  = { "Healer's Cap", "Republic Circlet" },
        neck  = { "Ajari Necklace", "Promise Badge", "Justice Badge" },
        ear1  = "Moldavite Earring",
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = "Ryl.Sqr. Robe +2",
        hands = "Devotee's Mitts",
        ring1 = { "Serenity Ring", "Solace Ring" },
        ring2 = { "Serenity Ring", "Solace Ring" },
        back  = "Red Cape +1",
        waist = "Penitent's Rope",
        legs  = "Healer's Pantaloons",
        feet  = "Healer's Duckbills"
    },

    Midcast_Elemental_Priority = {
        head  = "Seer's Crown +1",
        neck  = { "Checkered Scarf", "Black Neckerchief" },
        ear1  = "Moldavite Earring",
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = "Ryl.Sqr. Robe +2",
        hands = "Seer's Mitts +1",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Swift Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Healer's Duckbills"
    },
    
    Midcast_Dark_Priority = {
        head  = "Seer's Crown +1",
        neck  = { "Checkered Scarf", "Black Neckerchief" },
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = "Ryl.Sqr. Robe +2",
        hands = "Seer's Mitts +1",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Swift Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Healer's Duckbills"
    },    
    
    Midcast_Enhancing = {
        waist = "Swift Belt",
        feet  = "Healer's Duckbills"
    },
    
    Midcast_Enhancing_Stoneskin_Priority = { -- MND+ & Enhancing Skill
    main  = WaterStaff,
    head  = { "Healer's Cap", "Republic Circlet" },
    neck  = { "Ajari Necklace", "Promise Badge", "Justice Badge" },
    body  = "Ryl.Sqr. Robe +2",
    hands = "Devotee's Mitts",
    ring1 = { "Serenity Ring", "Solace Ring" },
    ring2 = { "Serenity Ring", "Solace Ring" },
    back  = "Red Cape +1",
    waist = "Penitent's Rope",
    legs  = "Crow Hose",
    feet  = "Healer's Duckbills"
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
        gFunc.EquipSet(sets.TP);
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
        gFunc.EquipSet(sets.Midcast_Divine);
        if (conquest.GetInsideControl()) then
            gFunc.Equip('head', 'Republic Circlet');
        end
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Midcast_Dark);
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Midcast_Elemental);
        if (conquest.GetInsideControl()) then
            gFunc.Equip('head', 'Republic Circlet');
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        if (string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') or string.contains(spell.Name, 'Silence')) then
            gFunc.EquipSet(sets.Midcast_Enfeebling_Mnd);
        else
            gFunc.EquipSet(sets.Midcast_Enfeebling);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Midcast_Cure);
        if (player.MainJobSync >= 50 and (player.HP / player.MaxHP <= .75) and spell.Name:contains("Cure")) then
            gFunc.Equip('ring1', 'Medicine Ring');
        end
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
    includes.HandleMidcast();
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS);
end

profile.HandleCommand = function(args)
    local player = gData.GetPlayer();
    if (args[1] == 'regen') then
        if (player.MainJobSync >= 44) then
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Regen II"');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Regen"');
        end
    elseif (args[1] == 'dia') then
        if (player.MainJobSync >= 36) then
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Dia II" <t>');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Dia" <t>');
        end
    end
    includes.HandleCommands(args);
end

return profile;
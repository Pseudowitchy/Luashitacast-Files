local profile = {};
includes = gFunc.LoadFile('includes.lua');
display = gFunc.LoadFile('display.lua');
conquest = gFunc.LoadFile('conquest.lua');
nukeReqs = gFunc.LoadFile('SpellReqs.lua');

macroBook = 2;
macroSet  = 1; -- Page within book
lockstyleSet = 198; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Blink';
util2     = 'Stoneskin';
jobText = '';

uggyPendant = true; -- Sets if Uggalepih Pendant should be used when the latent can be triggered.
sorcRing = false; -- Sets if Sorc Ring features should be used, if you don't have the ring leave false
sorcRing_Slot = 'ring1'; -- overwrites existing ring in this slot when Sorc Ring is toggled on

local sets = {
    Idle = {
        main  = EarthStaff,
        ammo  = "Phtm. Tathlum",
        neck  = "Jeweled Collar",
        ear1  = "Merman's Earring",
        ear2  = "Merman's Earring",
        body  = "Vermillion Cloak",
        hands = "Sly Gauntlets",
        ring1 = "Merman's Ring",
        ring2 = "Merman's Ring",
        back  = "Cheviot Cape",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Wizard's Sabots"
    },

    Resting = {
        main  = DarkStaff,
        neck  = "Checkered Scarf",
        body  = "Vermillion Cloak",
        waist = "Hierarch Belt",
        legs  = "Baron's Slops",
    },

    Precast = { -- Fast Cast
    
    },

    Precast_Sorc = { -- Fast Cast, -hp gear to trigger Sorc Ring
    
    },

    Midcast = { -- Spell Interruption Rate
        waist = "Heko Obi +1",
        feet  = "Wizard's Sabots"
    },

    Midcast_Elemental_Dmg = { -- INT & MAB > Skill
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Moldavite Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cotehardie",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Wizard's Sabots"
    },

    Midcast_Elemental_Macc = { -- Skill & MACC > INT & MAB
        ammo  = "Phtm. Tathlum",
        head  = "",
        neck  = "Philomath Stole",
        ear1  = "Moldavite Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cloak",
        hands = "Wizard's Gloves",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Druid's Slops",
        feet  = "Wizard's Sabots"
    },
    
    Midcast_Elemental_MB_Dmg = { -- MB Bonus > INT & MAB > Skill & MACC 
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Moldavite Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cotehardie",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Wizard's Sabots"
    },

    Midcast_Elemental_MB_Macc = { -- MB Bonus > Skill & MACC > INT & MAB
        ammo  = "Phtm. Tathlum",
        head  = "",
        neck  = "Philomath Stole",
        ear1  = "Moldavite Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cloak",
        hands = "Wizard's Gloves",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Druid's Slops",
        feet  = "Wizard's Sabots"
    },

    Midcast_Elemental_DoTs = { -- INT > MACC
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cotehardie",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Druid's Slops",
        feet  = "Wizard's Sabots"
    },

    Midcast_Dark = { -- Skil > MACC > INT
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cotehardie",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Wizard's Tonban",
        feet  = "Wizard's Sabots"
    },

    Midcast_Stun = { -- Skil > MACC > INT
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Black Cotehardie",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Wizard's Tonban",
        feet  = "Wizard's Sabots"
    },

    Midcast_Enfeebling = { -- Skil > MACC > INT
        ammo  = "Phtm. Tathlum",
        head  = "Wizard's Petasos",
        neck  = "Philomath Stole",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Wizard's Coat",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Wizard's Sabots"
    },

    Midcast_Enfeebling_Mnd = { -- Skil > MACC > MND
        head  = "Republic Circlet",
        neck  = "Justice Badge",
        body  = "Wizard's Coat",
        hands = "Devotee's Mitts",
        ring1 = "Solace Ring",
        ring2 = "Solace Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        feet  = "Seer's Pumps +1"
    },

    Midcast_Healing = {  -- Skil > MND
        head  = "Republic Circlet",
        neck  = "Justice Badge",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Devotee's Mitts",
        ring1 = "Solace Ring",
        ring2 = "Solace Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Druid's Slops",
        feet  = "Seer's Pumps +1"
    },

    TP = {

    },

    Town = {
        main  = "Mandibular Sickle",
        legs  = "Druid's Slops",
    },

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);

    AshitaCore:GetChatManager():QueueCommand(1, '/alias /sleepga /lac fwd sleepga');

    AshitaCore:GetChatManager():QueueCommand(1, '/bind !` /ma "Stun" <t>');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f11 /lac fwd stat');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind home /lac fwd mb');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind end /lac fwd eleFwd');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind delete /lac fwd eleBack');
    
    includes.OnLoad();
    
    display.Load();
    display.CreateCycle('Stat Focus', { [1] = 'Dmg', [2] = 'Macc' });
    display.CreateCycle('Element', { [1] = '|cFF9366FA|Thunder', [2] = '|cFFDD0000|Fire',  [3] = '|cFF0BDE27|Aero',
                                     [4] = '|cFF8B8B13|Stone',   [5] = '|cFF0066CC|Water', [6] = '|cFF00CCCC|Blizzard' });
    display.CreateToggle('Magic Burst', false);
    if (sorcRing == true) then
        display.CreateToggle('Sorc. Ring', false);
        AshitaCore:GetChatManager():QueueCommand(1, '/bind !home /lac fwd sorc');
    end    
end

profile.OnUnload = function()

    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /sleepga');

    AshitaCore:GetChatManager():QueueCommand(1, '/unbind !`');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f11');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind home');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind end');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind delete');

    includes.OnUnload();

    display.Unload();

    if (sorcRing == true) then
        AshitaCore:GetChatManager():QueueCommand(1, '/unbind !home');
    end   
end

local EleDoTs = T{ 'Burn', 'Frost', 'Choke', 'Rasp', 'Shock', 'Drown' }

profile.HandleDefault = function()
    local player = gData.GetPlayer();

    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.TP);
    elseif (player.Status == 'Resting') then
        if (player.MainJobSync < 59) then
            gFunc.Equip('body', "Seer's Tunic +1");
        elseif (player.MainJobSync < 51) then
            gFunc.Equip('main', "Pilgrim's Wand");
            gFunc.Equip('body', "Seer's Tunic +1");
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

    if (spell.Skill == 'Elemental Magic' or spell.Name == 'Drain' or spell.Name == 'Aspir') then
        gFunc.EquipSet(sets.Precast_Sorc);
    elseif (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.EPrecast_Enhancing);

        if string.contains(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Precast_Enhancing_Stoneskin);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Precast_Healing);
    end

    includes.CheckDefaults();
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (spell.Skill == 'Elemental Magic') then
        if (display.GetToggle('Magic Burst') == true) then
            gFunc.EquipSet('Midcast_Elemental_MB_' .. display.GetCycle("Stat Focus"));
        else
            gFunc.EquipSet('Midcast_Elemental_' .. display.GetCycle("Stat Focus"));
        end

        if (EleDoTs:contains(spell.Name)) then
            gFunc.EquipSet(sets.Midcast_Elemental_DoTs);
        end

        if (conquest.GetInsideControl()) then
            if (not EleDoTs:contains(spell.Name)) then
                gFunc.Equip('head', 'Republic Circlet');
            end
            gFunc.Equip('body', 'Ryl.Sqr. Robe +2');
        end

        if (sorcRing) then
            gFunc.Equip(sorcRing_Slot, 'Sorcerer\' Ring');
        end
        if (uggyPendant and spell.MppAftercast < 51 and player.MainJobSync >= 70) then
            gFunc.Equip('neck', 'Uggalepih Pendant');
        end
    elseif (spell.Skill == 'Dark Magic') then
        if (spell.Name == 'Drain' or spell.Name == 'Aspir') then
            gFunc.EquipSet(sets.Midcast_Dark);
            if (conquest.GetInsideControl()) then
                gFunc.Equip('head', 'Republic Circlet');
                gFunc.Equip('body', 'Ryl.Sqr. Robe +2');
            end
            if (sorcRing) then
                gFunc.Equip(sorcRing_Slot, 'Sorcerer\' Ring');
            end
            if (uggyPendant and spell.MppAftercast < 51 and player.MainJobSync >= 70) then
                gFunc.Equip('neck', 'Uggalepih Pendant');
            end
        else
            gFunc.EquipSet(sets.Midcast_Stun);
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        if string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') then
            gFunc.EquipSet(sets.Midcast_Enfeebling_Mnd);
        else
            gFunc.EquipSet(sets.Midcast_Enfeebling);
            if (conquest.GetOutsideControl() and player.MainJobSync >= 65) then
                gFunc.Equip('hands', 'Mst.Cst. Bracelets');
            end
        end

    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Midcast_Healing);
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
    end

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
    includes.HandleMidcast();
end

profile.HandleCommand = function(args)
    if args[1] == 'sleep' then
        DoSleep();
    elseif args[1] == 'sleepga' then
        DoSleepga();
    elseif args[1] == 'eleFwd' then
        display.AdvanceCycle('Element');
    elseif args[1] == 'eleBack' then
        display.AdvanceCycleBack('Element');
    elseif args[1] == 'mb' then
        display.AdvanceToggle('Magic Burst');
    elseif args[1] == 'stat' then
        display.AdvanceCycle('Stat Focus');
    elseif args[1] == 'sorc' then
        display.AdvanceToggle('Sorc. Ring');
    elseif args[1] == 'nuke' then
        if (args[2] ~= nil and (tonumber(args[2]) >= 1 and tonumber(args[2]) <= 4)) then
            DoNuke(tonumber(args[2]));
        else includes.echoToChat('Invalid Command. ', '/lac fwd nuke (1/2/3/4)');
        end
    else includes.HandleCommands(args);
    end
end

function DoNuke(nukeTier)
    local player = gData.GetPlayer();
    local element = string.sub(display.GetCycle('Element'), 12, -1);
    local tier = nukeTier;
    local nukeDowngrade = false;
    local reason = '';

    while (tier > 1) do
        if (player.MainJobSync >= nukeReqs['BLM'][element][tier][1] and
         player.MP >= nukeReqs['BLM'][element][tier][2]) then
            break
         else
            nukeDowngrade = true;
            tier = tier - 1;
            if (player.MainJobSync < nukeReqs['BLM'][element][tier][1]) then
                reason = 'Too low level.';
            else reason = 'Not enough MP.';
            end
        end
    end

    if (nukeDowngrade) then
        includes.echoToChat('Spell being downgraded: ', reason)
    end

    if (tier == '4') then tier = ' IV';
    elseif (tier == '3') then tier = ' III';
    elseif (tier == '2') then tier = ' II';
    elseif (tier == '1') then tier = '';
    end
    AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. element .. tier .. '" <t>');
end

function DoSleep()
	local player = gData.GetPlayer()
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(259);

    if (player.MainJobSync >= 41 and recast1 == 0 and player.MP >= 29) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep II" <t>');	
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep" <t>');
    end
end

function DoSleepga()
	local player = gData.GetPlayer()
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(274);

    if (player.MainJobSync >= 56 and recast1 == 0 and player.MP >= 58) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleepga II" <t>');	
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleepga" <t>');
    end
end

return profile;
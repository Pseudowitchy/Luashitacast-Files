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

local fullMP = 918; -- Your "max" mp, when to swap out of refresh gear and into full idle set.

relicLegs = true; -- Do you have BLM Relic legs?
uggyPendant = true; -- Do you have Uggalepih Pendant?
sorcRing = false; -- Do you have Sorc Ring? Will activate a toggle for when to/not to use ring
sorcRing_Slot = 'ring1'; -- Where to equip Sorc ring to when in use

local sets = {
    Idle_Priority = {
        main  = { EarthStaff, "Rose Wand +1", "Solid Wand", "Yew Wand +1" },
        sub   = { { "", Level = 51 }, "Rose Wand +1", "Solid Wand", "Yew Wand +1" },
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { { "Green Ribbon +1", Level = 74 }, { "", Level = 59 }, "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Jeweled Collar", "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Merman's Earring", "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Merman's Earring", "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Sorcerer's Coat", "Vermillion Cloak", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Merman's Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Merman's Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Cheviot Cape", "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt", },
        legs  = { "Errant Slops", "Seer's Slacks +1" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots" },
    },

    Resting_Priority = {
        main  = { DarkStaff, "Pilgrim's Wand" },
        neck  = { "Checkered Scarf" },
        body  = { "Errant Hpl.", "Vermillion Cloak", "Seer's Tunic +1" },
        waist = { "Hierarch Belt" },
        legs  = { "Baron's Slops" },
    },

    Precast_Priority = { -- Fast Cast
    feet  = "Rostrum Pumps"
},

    Precast_Sorc_Priority = { -- Fast Cast, -hp gear to trigger Sorc Ring
    
    },

    Midcast_Priority = { -- Spell Interruption Rate
        waist = { "Heko Obi +1" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots" }
    },

    Midcast_Elemental_Dmg_Priority = { -- INT & MAB > Skill
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Igqira Weskit", "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Errant Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Elemental_Macc_Priority = { -- Skill & MACC > INT & MAB
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Sorcerer's Petas.", "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Igqira Weskit", "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Wizard's Gloves", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Druid's Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Elemental_MB_Dmg_Priority = { -- MB Bonus > INT & MAB > Skill & MACC 
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Igqira Weskit", "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Sorcerer's Gloves", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Errant Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Elemental_MB_Macc_Priority = { -- MB Bonus > Skill & MACC > INT & MAB
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Sorcerer's Petas.", "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Igqira Weskit", "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Sorcerer's Gloves", "Wizard's Gloves", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Druid's Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Elemental_DoTs_Priority = { -- INT > MACC
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = { "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Errant Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Dark_Priority = { -- Skill > MACC > INT
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = { "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Sorcerer's Gloves", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Wizard's Tonban", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Stun_Priority = { -- Skill > MACC > INT
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Demon Helm", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Phantom Earring", "Morion Earring" },
        ear2  = { "Phantom Earring", "Morion Earring" },
        body  = { "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Sorcerer's Gloves", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Wizard's Tonban", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Enfeebling_Priority = { -- Skill > MACC > INT
        ammo  = { "Phtm. Tathlum", "Sweet Sachet", "Morion Tathlum" },
        head  = { "Igqira Tiara", "Wizard's Petasos", "Seer's Crown +1", "Baron's Chapeau" },
        neck  = { "Philomath Stole", "Checkered Scarf", "Black Necherchief" },
        ear1  = { "Moldavite Earring", "Morion Earring", "Energy Earring" },
        ear2  = { "Phantom Earring", "Morion Earring", "Energy Earring" },
        body  = { "Wizard's Coat", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Sly Gauntlets", "Seer's Mitts +1" },
        ring1 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        ring2 = { "Diamond Ring", "Wisdom Ring", "Eremite's Ring" },
        back  = { "Red Cape +1", "Black Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Errant Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Wizard's Sabots", "Seer's Pumps +1"},
    },

    Midcast_Enfeebling_Mnd_Priority = { -- Skill > MACC > MND
        head  = { "Igqira Tiara", "Republic Circlet", "Seer's Crown +1" },
        neck  = { "Promise Badge", "Justice Badge" },
        body  = { "Wizard's Coat", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Devotee's Mitts" },
        ring1 = { "Solace Ring" },
        ring2 = { "Solace Ring" },
        back  = { "Red Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Errant Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Errant Pigaches", "Seer's Pumps +1" },
    },

    Midcast_Healing_Priority = {  -- Skill > MND
        head  = { "Zenith Crown", "Republic Circlet", "Seer's Crown +1" },
        neck  = { "Promise Badge", "Justice Badge" },
        body  = { "Errant Hpl.", "Ryl.Sqr. Robe +2", "Baron's Saio" },
        hands = { "Errant Cuffs", "Devotee's Mitts" },
        ring1 = { "Solace Ring" },
        ring2 = { "Solace Ring" },
        back  = { "Gigant Mantle", "Red Cape +1" },
        waist = { "Penitent's Rope", "Mrc.Cpt. Belt" },
        legs  = { "Druid Slops", "Seer's Slacks +1", "Baron's Slops" },
        feet  = { "Rostrum Pumps", "Errant Pigaches", "Seer's Pumps +1" },
    },

    TP_Priority = {

    },

    Town_Priority = {
        main  = "Mandibular Sickle",
    },

    Movement_Priority = {},
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

-- Leave these bits alone :3
jobText = '';
local CurrentLevel = 0;
local EleDoTs = T{ 'Burn', 'Frost', 'Choke', 'Rasp', 'Shock', 'Drown' };
-- Those bits up there~

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
        if (player.MainJobSync == 75 and player.MP >= fullMP) then
            gFunc.Equip('head', 'Green Ribbon +1');
            gFunc.Equip('body', 'Igqira Weskit');
        end
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
        gFunc.EquipSet(sets.Precast_Enhancing);

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
    local environment = gData.GetEnvironment();

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
            if (player.MainJobSync < 72) then
                gFunc.Equip('body', 'Ryl.Sqr. Robe +2');
            end
        end

        if  (not EleDoTs:contains(spell.Name)) then
            if (sorcRing and (player.HP / player.MaxHP <= .75)) then
                gFunc.Equip(sorcRing_Slot, 'Sorcerer\'s Ring');
            end
            if (uggyPendant and spell.MppAftercast < 51 and player.MainJobSync >= 70) then
                gFunc.Equip('neck', 'Uggalepih Pendant');
            end
            if (spell.Element == environment.DayElement and player.MainJobSync >= 73 and relicLegs == true) then
                gFunc.Equip('legs', 'Sorcerer\'s Tonban');
            end
        end
    elseif (spell.Skill == 'Dark Magic') then
        if (spell.Name == 'Drain' or spell.Name == 'Aspir') then
            gFunc.EquipSet(sets.Midcast_Dark);
            if (conquest.GetInsideControl() and player.MainJobSync < 72) then
                gFunc.Equip('body', 'Ryl.Sqr. Robe +2');
            end
        else
            gFunc.EquipSet(sets.Midcast_Stun);
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        if string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') then
            gFunc.EquipSet(sets.Midcast_Enfeebling_Mnd);
        else
            gFunc.EquipSet(sets.Midcast_Enfeebling);
        end
        if (conquest.GetOutsideControl() and player.MainJobSync >= 65) then
            gFunc.Equip('hands', 'Mst.Cst. Bracelets');
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Midcast_Healing);
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
        if (player.MainJobSync >= 71) then
            includes.ObiCheck();
        end
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
        if ((player.MainJobSync >= nukeReqs['BLM'][element][tier][1]) and
            (player.MP >= nukeReqs['BLM'][element][tier][2])) then
            break
         else
            if (nukeDowngrade == false) then
                if (player.MainJobSync < nukeReqs['BLM'][element][tier][1]) then
                    reason = 'Too low level.';
                else reason = 'Not enough MP.';
                end
            end
            tier = tier - 1;
            nukeDowngrade = true;
        end
    end

    if (nukeDowngrade) then
        includes.echoToChat('Spell being downgraded: ', reason)
    end

    if (tier == 4) then tier = ' IV';
    elseif (tier == 3) then tier = ' III';
    elseif (tier == 2) then tier = ' II';
    elseif (tier == 1) then tier = '';
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
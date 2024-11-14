local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 2;
macroSet  = 1; -- Page within book
lockstyleSet = 198; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Aquaveil';
util2     = 'Blink';

local sets = {
    Idle = {
        main  = EarthStaff,
        ammo  = "Sweet Sachet",
        head  = "Seer's Crown +1",
        neck  = "Black Neckerchief",
        ear1  = "Moldavite Earring",
        ear2  = "Morion Earring",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Black Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Mage's Sandals"
    },
    
    Resting = {
        main  = DarkStaff,
        neck  = "Checkered Scarf",
        body  = "Seer's Tunic +1",
        legs  = "Baron's Slops",
    },
    
    Precast = { -- Fast Cast
    
    },
    
    Midcast = { -- Spell Interruption Rate
        feet  = "Wizard's Sabots"
    },
    
    Nuke = {
        ear1  = "Moldavite Earring",
        hands = "Wizard's Gloves",
    },
    
    Dark = {
        legs  = "Wizard's Tonban",
    },
    
    Enfeebling = {
        ear1  = "Morion Earring",
        body  = "Wizard's Coat",
    },

    Enfeebling_Potency = {
        ear1  = "Morion Earring",
        body  = "Wizard's Coat",
    },
    
    Mnd_Enfeebling = {
        neck  = "Justice Badge",
        body  = "Wizard's Coat",
    },
    
    TP = {
    
    },
    
    Town = {
        main  = "Mandibular Sickle",
        ear1  = "Moldavite Earring",
    },

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);
        
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /stone /lac fwd stone');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /water /lac fwd water');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /aero /lac fwd aero');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /fire /lac fwd fire');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /blizzard /lac fwd blizzard');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /thunder /lac fwd thunder');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /sleepga /lac fwd sleepga');
    
    AshitaCore:GetChatManager():QueueCommand(1, '/bind !` /ma "Stun" <t>');

    includes.OnLoad();
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /stone');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /water');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /aero');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /fire');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /blizzard');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /thunder');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /sleepga');
    
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind !`');
    
    includes.OnUnload();
end

local EleDoTs = T{ 'Burn', 'Frost', 'Choke', 'Rasp', 'Shock', 'Drown' }

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
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
        gFunc.EquipSet(sets.Enhancing_Precast);

        if string.contains(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin_Precast);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure_Precast);
    end
end
    
profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Dark);
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
        if (EleDoTs:contains(spell.Name)) then
            gFunc.EquipSet(sets.Enfeebling_Potency);
        elseif string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') then
            gFunc.EquipSet(sets.Mnd_Enfeebling);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
    end
end

profile.HandleCommand = function(args)
    if args[1] == 'stone' then
        DoStone();
    elseif args[1] == 'water' then
        DoWater();
    elseif args[1] == 'aero' then
        DoAero(); 
    elseif args[1] == 'fire' then
        DoFire();
    elseif args[1] == 'blizzard' then  
        DoBlizzard();
    elseif args[1] == 'thunder' then
        DoThunder();
    elseif args[1] == 'sleep' then
        DoSleep();
    elseif args[1] == 'sleepga' then
        DoSleepga();
    else includes.HandleCommands(args);
    end
end

function DoStone()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(162);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(161);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(160);
	
    if (player.MainJobSync >= 68 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone IV" <t>');
    elseif (player.MainJobSync >= 51 and recast3 == 0 and player.MP >= 92) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone III" <t>');
    elseif (player.MainJobSync >= 26 and recast2 == 0 and player.MP >= 43) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone" <t>');
    end
end

function DoWater()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(172);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(171);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(170);
	
    if (player.MainJobSync >= 70 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water IV" <t>');
    elseif (player.MainJobSync >= 55 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water III" <t>');
    elseif (player.MainJobSync >= 30 and recast2 == 0 and player.MP >= 51) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water" <t>');
    end
end

function DoAero()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(157);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(156);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(155);
	
    if (player.MainJobSync >= 72 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero IV" <t>');
    elseif (player.MainJobSync >= 59 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero III" <t>');
    elseif (player.MainJobSync >= 34 and recast2 == 0 and player.MP >= 59) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero" <t>');
    end
end

function DoFire()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(147);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(146);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(145);
	
    if (player.MainJobSync >= 73 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire IV" <t>');
    elseif (player.MainJobSync >= 62 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire III" <t>');
    elseif (player.MainJobSync >= 38 and recast2 == 0 and player.MP >= 68) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire" <t>');
    end
end

function DoBlizzard()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(152);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(151);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(150);
	
    if (player.MainJobSync >= 74 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard IV" <t>');
    elseif (player.MainJobSync >= 64 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard III" <t>');
    elseif (player.MainJobSync >= 42 and recast2 == 0 and player.MP >= 77) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard" <t>');
    end
end

function DoThunder()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(167);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(166);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(165);
	
    if (player.MainJobSync >= 75 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder IV" <t>');
    elseif (player.MainJobSync >= 66 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder III" <t>');
    elseif (player.MainJobSync >= 46 and recast2 == 0 and player.MP >= 86) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder" <t>');
    end
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

    if (player.MainJobSync >= 56 and recast1 == 0 and player.MP >= 100) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep II" <t>');	
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep" <t>');
    end
end

return profile;
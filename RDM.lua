local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 5;
macroSet  = 1; -- Page within book
lockstyleSet = 197; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Paralyna';
util2     = 'Blink';

Wand = "Rose Wand +1"
Sword = "Knight's Sword +1"
NinSword = "Buzzard Tuck"
Shield = "Frost Shield"

local sets = {
    Idle = {
        main  = EarthStaff,
        ammo  = "Sweet Sachet",
        neck  = "Checkered Scarf",
        ear1  = "Moldavite Earring",
        ear2  = "Morion Earring",
        body  = "Vermillion Cloak",
        hands = "Crow Bracers",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Ryl.Kgt. Belt",
        legs  = "Crow Hose",
        feet  = "Crow Gaiters",
    },
    
    Idle_NIN = {
        main  = Sword,
        sub   = NinSword,
        ammo  = "Sweet Sachet",
        neck  = "Checkered Scarf",
        ear1  = "Moldavite Earring",
        ear2  = "Morion Earring",
        body  = "Vermillion Cloak",
        hands = "Crow Bracers",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Sarashi",
        legs  = "Crow Hose",
        feet  = "Crow Gaiters",
    },    
    Resting = {
        main  = DarkStaff,
        neck  = "Checkered Scarf",
        legs  = "Baron's Slops",
    },
    
    Precast = { -- Fast Cast
        head  = "Warlock's Chapeau",
    },
    
    Midcast = { -- Spell Interruption Rate
        head  = "Crow Beret",
        body  = "Warlock's Tabard",
        hands = "Crow Bracers",
        waist = "Heko Obi +1",
        legs  = "Crow Hose",
        feet  = "Crow Gaiters",
    },
    
    Enfeebling = {
        head  = "Baron's Chapeau",
        neck  = "Checkered Scarf",
        ear1  = "Morion Earring",
        ear2  = "Morion Earring",
        body  = "Warlock's Tabard",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        legs  = "Magic Cuisses",
        feet  = "Warlock's Boots"
    },
    
    Mnd_Enfeebling = {equip = Enfeebling,
        head  = "Traveler's Hat",
        body  = "Warlock's Tabard",
        hands = "Baron's Cuffs",
        neck  = "Justice Badge",
        ring1 = "Solace Ring",
        ring2 = "Solace Ring",
        waist = "Ryl.Kgt. Belt",
        legs  = "Warlock's Tights",
        feet  = "Warlock's Boots"
    },
    
    Nuke = {
        head  = "Baron's Chapeau",
        neck  = "Checkered Scarf",
        ear1  = "Moldavite Earring",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        waist = "Ryl.Kgt. Belt",
        legs  = "Magic Cuisses",
        feet  = "Warlock's Boots"
    },
    
    Dark = {
        head  = "Baron's Chapeau",
        neck  = "Checkered Scarf",
        ear1  = "Moldavite Earring",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Sly Gauntlets",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        waist = "Ryl.Kgt. Belt",
        legs  = "Magic Cuisses",
        feet  = "Warlock's Boots"
    },
    
    Cure = {
        head  = "Traveler's Hat",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Baron's Cuffs",
        ring1 = "Solace Ring",
        ring2 = "Solace Ring",
        waist = "Ryl.Kgt. Belt",
        legs  = "Warlock's Tights",
        feet  = "Warlock's Boots"
    },
    
    Enhancing = {
        legs  = "Warlock's Tights",
    },
    
    Enhancing_Enspell = {
        main  = "Buzzard Tuck",
    },
    
    Enhancing_Stoneskin = {
        main  = "Rose Wand +1",
        head  = "Traveler's Hat",
        body  = "Ryl.Sqr. Robe +2",
        hands = "Baron's Cuffs",
        ring1 = "Solace Ring",
        ring2 = "Solace Ring",
        waist = "Ryl.Kgt. Belt",
        legs  = "Warlock's Tights",
        feet  = "Warlock's Boots"
    },
    
    TP = {
        main  = Sword,
        sub   = Shield,
        head  = "Cotton Headband",
        neck  = "Spike Necklace",
        ear1  = "Beetle Earring +1",
        ear2  = "Beetle Earring +1",
        body  = "Beetle Harness +1",
        hands = "Beetle Mittens +1",
        ring1 = "Courage Ring",
        ring2 = "Courage Ring",
        back  = "Nomad's Mantle",
        waist = "Ryl.Kgt. Belt",
        legs  = "Beetle Subligar +1",
        feet  = "Warlock's Boots"
    },
    
    TP_NIN = {
        main  = Sword,
        sub   = Shield,
        head  = "Cotton Headband",
        neck  = "Spike Necklace",
        ear1  = "Beetle Earring +1",
        ear2  = "Beetle Earring +1",
        body  = "Beetle Harness +1",
        hands = "Beetle Mittens +1",
        ring1 = "Courage Ring",
        ring2 = "Courage Ring",
        back  = "Nomad's Mantle",
        waist = "Sarashi",
        legs  = "Beetle Subligar +1",
        feet  = "Warlock's Boots"
    },    
    WS = {
        neck  = "Spike Necklace",
        ear1  = "Beetle Earring +1",
        ear2  = "Beetle Earring +1",
        hands = "Ryl.Ftm. Gloves",
        ring1 = "Courage Ring",
        ring2 = "Courage Ring",
        waist = "Ryl.Kgt. Belt",
    },
    
    Town = {
        hands = "Sly Gauntlets",
        legs  = "Magic Cuisses",
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
        if (player.SubJob == "NIN") then
            gFunc.EquipSet(sets.TP_NIN);
        else
            gFunc.EquipSet(sets.TP);
        end
    elseif (player.Status == 'Resting') then        
        if (player.MainJobSync < 51) then
            gFunc.Equip('main', "Pilgrim's Wand");                
        elseif (player.MainJobSync < 72) then
            gFunc.Equip('body', "Vermillion Cloak");
            gFunc.Equip('head', "Displaced");
        end
    else
		gFunc.EquipSet(sets.Idle);
        if (player.SubJob == "NIN") then
            gFunc.EquipSet(sets.Idle_NIN);
        elseif (player.SubJob == "WHM") then
            gFunc.Equip('waist', "Healer's Belt");
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
        if (player.SubJob == "WHM") then
            gFunc.Equip('waist', "Healer's Belt");
        end
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Dark);
    elseif (spell.Skill == 'Enfeebling Magic') then
        if (string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') or string.contains(spell.Name, 'Silence')) then
            gFunc.EquipSet(sets.Mnd_Enfeebling);
        else
            gFunc.EquipSet(sets.Enfeebling);

        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
        if (player.SubJob == "WHM") then
            gFunc.Equip('waist', "Healer's Belt");
        end
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
    elseif (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);
        if string.contains(spell.Name, 'En') then
            gFunc.EquipSet(sets.Enhancing_Enspell);
        elseif (spell.Name == 'Stoneskin') then
            gFunc.EquipSet(sets.Enhancing_Stoneskin);
        end    
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
    end
    
    if (player.SubJob == "NIN" and player.MainJobSync >= 20 and player.MainJobSync <= 50) then
        gFunc.Equip('sub', Wand)
    end

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS);
    
    -- if(string.match _skillname_ swap set etc here when needed
end

profile.HandleCommand = function(args)
    if (args[1] == 'stone') then
        DoStone();
    elseif (args[1] == 'water') then
        DoWater();
    elseif (args[1] == 'aero') then
        DoAero(); 
    elseif (args[1] == 'fire') then
        DoFire();
    elseif (args[1] == 'blizzard') then  
        DoBlizzard();
    elseif (args[1] == 'thunder') then
        DoThunder();
    elseif (args[1] == 'sleep') then
        DoSleep();
    else includes.HandleCommands(args);
    end
end

function DoStone()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(162);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(161);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(160);
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone IV" <t>');
    elseif (player.MainJobSync >= 65 and recast3 == 0 and player.MP >= 92) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stone III" <t>');
    elseif (player.MainJobSync >= 35 and recast2 == 0 and player.MP >= 43) then
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
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water IV" <t>');
    elseif (player.MainJobSync >= 67 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Water III" <t>');
    elseif (player.MainJobSync >= 40 and recast2 == 0 and player.MP >= 51) then
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
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero IV" <t>');
    elseif (player.MainJobSync >= 69 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aero III" <t>');
    elseif (player.MainJobSync >= 45 and recast2 == 0 and player.MP >= 59) then
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
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire IV" <t>');
    elseif (player.MainJobSync >= 71 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Fire III" <t>');
    elseif (player.MainJobSync >= 50 and recast2 == 0 and player.MP >= 68) then
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
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard IV" <t>');
    elseif (player.MainJobSync >= 73 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blizzard III" <t>');
    elseif (player.MainJobSync >= 55 and recast2 == 0 and player.MP >= 77) then
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
	
    if (player.MainJobSync >= 76 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder IV" <t>');
    elseif (player.MainJobSync >= 75 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder III" <t>');
    elseif (player.MainJobSync >= 60 and recast2 == 0 and player.MP >= 86) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Thunder" <t>');
    end
end

function DoSleep()
	local player = gData.GetPlayer()
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(259);

    if (player.MainJobSync >= 46 and recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep II" <t>');	
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sleep" <t>');
    end
end

return profile;
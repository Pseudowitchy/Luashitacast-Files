local profile = {};
includes = gFunc.LoadFile('includes.lua');

macroBook = 4;
macroSet  = 1; -- Page within book
lockstyleSet = 199; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Erase';
util2     = 'Stoneskin';

local sets = {
    Idle = {
        main = EarthStaff,
        range = "Mythic Harp +1",
        head  = "Green Ribbon +1",
        neck  = "Jeweled Collar",
        ear1  = "Merman's Earring",
        ear2  = "Merman's Earring",
        body  = "Scorpion Harness",
        hands = "Darksteel Mittens",
        ring1 = "Merman's Ring",
        ring2 = "Merman's Ring",
        back  = "Cheviot Cape",
        waist = "Gleeman's Belt",
        legs  = "Darksteel Subligar",
        feet  = "Dst. Leggings"
    },
    
    Idle_Weakened = {
        head  = "Zenith Crown",
        neck  = "Uggalepih Pendant",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Errant Hpl.",
        hands = "Errant Cuffs",
        ring1 = "Ether Ring",
        ring2 = "Astral Ring",
        back  = "",
        waist = "Adept Rope",
        legs  = "Zenith Slacks",
        feet  = "Rostrum Pumps"
    },
    
    Resting = {
        main = DarkStaff,
        ear2  = "Magnetic Earring",
        neck  = "Checkered Scarf",
        waist = "Hierarch Belt",
    },
    
    TP = {
        range = "Oliphant",
        head  = "Optical Hat",
        neck  = "Peacock Amulet",
        ear1  = "Merman's Earring",
        ear2  = "Merman's Earring",
        body  = "Scorpion Harness",
        hands = "Darksteel Mittens",
        ring1 = "Woodsman Ring",
        ring2 = "Woodsman Ring",
        back  = "Bard's Cape",
        waist = "Swift Belt",
        legs  = "Darksteel Subligar",
        feet  = "Dst. Leggings"
    },

    TP_SW = {
        main  = "Joyeuse",
        sub   = "Genbu Shield",
    },

    TP_DW = {
        main  = "Joyeuse",
        sub   = "Thanatos Baselard",
    },

    WS = {
        range = "Frenzy Fife",
        ear1  = "Merman's Earring",
        ear2  = "Merman's Earring",
        body  = "Bard's Jstcorps"
    },

    Precast = { -- FastCast
        range = "Angel Lyre",
        back  = "Gigant Mantle",
        feet  = "Rostrum Pumps"
    },

    Precast_Songs = { -- Minstrel Ring & +HP to trigger latent effect, FastCast to fill
        main  = "Tutelary",
        head  = "Walkure Mask",
        neck  = "Shield Pendant",
        ear1  = "Pigeon Earring",
        ear2  = "Pigeon Earring",
        body  = "Sha'ir Manteel",
        hands = "Bard's Cuffs",
        ring1 = "Minstrel's Ring",
        ring2 = "Bomb Queen Ring",
        back  = "Gigant Mantle",
        waist = "Adept's Rope",
        legs  = "Wonder Braccae",
        feet  = "Wonder Clomps"
    },

    Midcast = {
        range = "Angel Lyre",
        head  = "Green Ribbon +1",
        neck  = "Jeweled Collar",
        ear1  = "Merman's Earring",
        ear2  = "Magnetic Earring",
        body  = "Crow Jupon",
        hands = "Darksteel Mittens",
        ring1 = "Merman's Ring",
        ring2 = "Merman's Ring",
        back  = "Cheviot Cape",
        waist = "Heko Obi +1",
        legs  = "Darksteel Subligar",
        feet  = "Dst. Leggings"
    },

    Midcast_Songs_Buffs = { -- Max Singing Skill, CHR irrelevent 
        main  = "Chanter's Staff",
        range = "Oliphant",
        head  = "Bard's Roundlet",
        neck  = "Jeweled Collar",
        ear1  = "Merman's Earring",
        ear2  = "Merman's Earring",
        hands = "Choral Cuffs",
        ring1 = "Merman's Ring",
        ring2 = "Merman's Ring",
        back  = "Cheviot Cape",
        waist = "Swift Belt",
        legs  = "Darksteel Subligar",
        feet  = "Dst. Leggings"

    },
    
    Midcast_Songs_Debuffs = { -- Singing Skill followed by CHR and MACC, Overwritten below for specific songs
        main  = "Chanter's Staff",
        range = "Oliphant",
        head  = "Bard's Roundlet",
        body  = "Errant Hpl.",
        neck  = "Flower Necklace",
        ear1  = "Beastly Earring",
        ear2  = "Melody Earring",
        hands = "Choral Cuffs",
        ring1 = "Loyalty Ring",
        ring2 = "Allure Ring",
        back  = "Jester's Cape +1",
        waist = "Corsette +1",
        legs  = "Sha'ir Seraweels",
        feet  = "Sha'ir Crackows"
    },

    Midcast_Stoneskin = {
        main  = "Kirin's Pole",
        head  = "Zenith Crown",
        neck  = "Promise Badge",
        ear2  = "Magnetic Earring",
        body  = "Kirin's Osode",
        Hands = "Devotee's Mitts",
        ring1 = "Serenity Ring",
        ring2 = "Serenity Ring",
        back  = "Red Cape +1",
        waist = "Penitent's Rope",
        legs  = "Bard's Cannions",
        feet  = "Suzaku's Sune-Ate"
    },
    
    Minuet   = {range = "Cornette +1", legs = "Choral Cannions"},
    Madrigal = {range = "Traversiere +1", legs = "Choral Cannions"},
    March    = {range = "Faerie Piccolo", legs = "Choral Cannions"},
    Mambo    = {range = "Gemshorn +1", legs = "Choral Cannions"},
    Prelude  = {range = "Angel's Flute +1", legs = "Choral Cannions"},
    Paeon    = {range = "Ebony Harp +1", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},
    Carol    = {range = "Crumhorn +1", legs = "Choral Cannions"},
    Etude    = {range = "Rose Harp +1", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},
    Minne    = {range = "Harp +1", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},
    Ballad   = {range = "Oliphant", legs = "Choral Cannions"},
    Hymnus   = {range = "Angel Lyre", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},
    Mazurka  = {range = "Harlequin's Horn", legs = "Choral Cannions"},
    Lullaby  = {range = "Mary's Horn", legs = "Choral Cannions"},
    Elegy    = {range = "Horn +1", legs = "Choral Cannions"},
    Finale   = {range = "Military Harp", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},
    Requiem  = {range = "Siren Flute", legs = "Choral Cannions"},
    Threnody = {range = "Sorrowful Harp", ear2 = "String Earring", body = "Choral Jstcorps", feet = "Bard's Slippers"},

    Town = { },

    Movement = {},
};

profile.Sets = sets;

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/bind !grave /ma "Chocobo Mazurka" <me>');

    (function() includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) end):once(5);
    includes.OnLoad();
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind !grave');

    includes.OnUnload();
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.TP);
        if (player.SubJob == 'NIN') then
            gFunc.EquipSet(sets.TP_DW);
        else
            gFunc.EquipSet(sets.TP_SW);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else        
		gFunc.EquipSet(sets.Idle);
        if (player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM') then
            if (player.MP < 49) then
                gFunc.Equip('body', 'Gaudy Harness');
            elseif (player.MP < 194) then
                gFunc.Equip('head', '');
                gFunc.Equip('body', 'Vermillion Cloak');
            end
        end

        if (gData.GetBuffCount("Weakness") > 0 and gData.GetBuffCount("Reraise") == 0) then
            gFunc.EquipSet(sets.Idle_Weakened)
        end
    end
    
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
    
	includes.CheckDefaults();
end
    
profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast);

    if (spell.Skill == 'Singing') then
        gFunc.EquipSet(sets.Precast_Songs)
    end
end
    
profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (spell.Skill == 'Singing') then        
        if (string.contains(spell.Name, 'Threnody') or string.contains(spell.Name, 'Elegy')
         or string.contains(spell.Name, 'Finale') or string.contains(spell.Name, 'Lullaby')
         or string.contains(spell.Name, 'Requiem')or string.contains(spell.Name, 'Virelai')) then
            gFunc.EquipSet(sets.Midcast_Songs_Debuffs);
            if (player.MainJobSync < 65) then
                gFunc.Equip('head', 'Noble\'s Ribbon');
            elseif (player.MainJobSync < 72) then
                gFunc.Equip('head', 'Opo-opo Crown');
                gFunc.Equip('body', 'Gaudy Harness');
            elseif (player.MainJobSync < 73) then
                gFunc.Equip('head', 'Opo-opo Crown');
            end
        else
            gFunc.EquipSet(sets.Midcast_Songs_Buffs);
        end

        if string.contains(spell.Name, 'Minuet') then
            gFunc.EquipSet(sets.Minuet);
        elseif string.contains(spell.Name, 'March') then
            gFunc.EquipSet(sets.March);
        elseif string.contains(spell.Name, 'Madrigal') then
            gFunc.EquipSet(sets.Madrigal);
        elseif string.contains(spell.Name, 'Mambo') then
            gFunc.EquipSet(sets.Mambo);
        elseif string.contains(spell.Name, 'Paeon') then
            gFunc.EquipSet(sets.Paeon);
        elseif string.contains(spell.Name, 'Minne') then
            gFunc.EquipSet(sets.Minne);
        elseif string.contains(spell.Name, 'Threnody') then
            gFunc.EquipSet(sets.Threnody);
        elseif string.contains(spell.Name, 'Etude') then
            gFunc.EquipSet(sets.Etude);
        elseif string.contains(spell.Name, 'Elegy') then
            gFunc.EquipSet(sets.Elegy);
        elseif string.contains(spell.Name, 'Requiem') then
            gFunc.EquipSet(sets.Requiem);
        elseif string.contains(spell.Name, 'Prelude') then
            gFunc.EquipSet(sets.Prelude);
        elseif string.contains(spell.Name, 'Ballad') then
            gFunc.EquipSet(sets.Ballad);
        elseif string.contains(spell.Name, 'Lullaby') then
            gFunc.EquipSet(sets.Lullaby);
        elseif string.contains(spell.Name, 'Carol') then
            gFunc.EquipSet(sets.Carol);
        elseif string.contains(spell.Name, 'Mazurka') then
            gFunc.EquipSet(sets.Mazurka);
        elseif string.contains(spell.Name, 'Finale') then
            gFunc.EquipSet(sets.Finale);
        elseif string.contains(spell.Name, 'Hymnus') then
            gFunc.EquipSet(sets.Hymnus);
        elseif string.contains(spell.Name, 'Threnody') then
            gFunc.EquipSet(sets.Threnody);
            if {player.MainJobSync < 70} then
                gFunc.Equip('range', 'Piccolo +1');
            end
        end
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Drain);
    elseif (spell.Skill == 'Enhancing Magic') then
        if string.contains(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Midcast_Stoneskin);
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
    if (args[1] == 'minuet') then
        DoMinuet();
    elseif (args[1] == 'madrigal') then
        DoMadrigal();
    elseif (args[1] == 'march') then
        DoMarch(); 
    elseif (args[1] == 'mambo') then
        DoMambo();
    elseif (args[1] == 'ballad') then  
        DoBallad();
    elseif (args[1] == 'minne') then
        DoMinne();
    elseif (args[1] == 'paeon') then
        DoPaeon();
    elseif (args[1] == 'requiem') then
        DoRequiem();
    elseif (args[1] == 'elegy') then
        DoElegy();
    else includes.HandleCommands(args);
    end    
end

function DoMinuet()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(397);
    local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(396);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(395);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(394);
	
    if (player.MainJobSync >= 63 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Valor Minuet IV" <me>');
    elseif (player.MainJobSync >= 43 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Valor Minuet III" <me>');
    elseif (player.MainJobSync >= 23 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Valor Minuet II" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Valor Minuet" <me>');
    end
end

function DoRequiem()
	local player = gData.GetPlayer()
    if (player.MainJobSync >= 67) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem VI" <t>');
    elseif (player.MainJobSync >= 57) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem V" <t>');
    elseif (player.MainJobSync >= 47) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem IV" <t>');
    elseif (player.MainJobSync >= 37) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem III" <t>');
    elseif (player.MainJobSync >= 17) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem II" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Foe Requiem" <t>');
    end
end

function DoElegy()
	local player = gData.GetPlayer()

    if (player.MainJobSync >= 59) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Carnage Elegy" <t>');
    else
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Battlefield Elegy" <t>');
    end
end

function DoMadrigal()
	local player = gData.GetPlayer()
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(400);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(399);
	
    if (player.MainJobSync >= 51 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Blade Madrigal" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sword Madrigal" <me>');
    end
end

function DoMarch()
	local player = gData.GetPlayer()
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(420);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(419);
	
    if (player.MainJobSync >= 60 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Victory March" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Advancing March" <me>');
    end
end

function DoMambo()
	local player = gData.GetPlayer()
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(404);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(403);
	
    if (player.MainJobSync >= 53 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Dragonfoe Mambo" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sheepfoe Mambo" <me>');
    end
end

function DoBallad()
	local player = gData.GetPlayer()
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(387);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(386);
	
    if (player.MainJobSync >= 55 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Mage\'s Ballad II" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Mage\'s Ballad" <me>');
    end
end

function DoMinne()
	local player = gData.GetPlayer()
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(392);
	local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(391);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(390);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(389);
	
    if (player.MainJobSync >= 61 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Knight\'s Minne IV" <me>');
    elseif (player.MainJobSync >= 41 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Knight\'s Minne III" <me>');
    elseif (player.MainJobSync >= 21 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Knight\'s Minne II" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Knight\'s Minne" <me>');
    end
end

function DoPaeon()
	local player = gData.GetPlayer()
	local recast5 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(382);
	local recast4 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(381);
	local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(380);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(379);
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(378);

    if (player.MainJobSync >= 65 and recast5 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Army\'s Paeon V" <me>');	
    elseif (player.MainJobSync >= 45 and recast4 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Army\'s Paeon IV" <me>');
    elseif (player.MainJobSync >= 35 and recast3 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Army\'s Paeon III" <me>');
    elseif (player.MainJobSync >= 15 and recast2 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Army\'s Paeon II" <me>');
    elseif (recast1 == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/ma "Army\'s Paeon" <me>');
    end
end

return profile;
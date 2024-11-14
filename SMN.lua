local profile = {};
includes = gFunc.LoadFile('includes.lua');

tTimers = true; -- Do you use TTimers addon? Tracks avatar buff durations into the Custom timers section.

macroBook = 3;
macroSet  = 1; -- Page within book
lockstyleSet = 200; -- which macro equipset do you use for lockstyle

-- Util spells, usable via /lac fwd (util1/util2) (optional spell name to update spell)
-- Utilizes shortcuts addon to input via // commands
-- Change default spells below, or leave blank: ''
util1     = 'Paralyna';
util2     = 'Blink';

avatarElement = ''; -- For comparing current weather with pet element for -perp gear, leave blank

local sets = {
    Idle = {
        main  = EarthStaff,
        ammo  = "Phtm. Tathlum",
        head  = "",
        neck  = "Uggalepih Pendant",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Vermillion Cloak",
        hands = "Errant Cuffs",
        ring1 = "Ether Ring",
        ring2 = "Evoker's Ring",
        back  = "Summoner's Cape",
        waist = "Hierarch Belt",
        legs  = "Evoker's Spats",
        feet  = "Summoner's Pgch."
    },

    Idle_50 = {
        main  = "Kukulcan's Staff",
        ammo  = "Morion Tathlum",
        head  = "Crow Beret",
        neck  = "Justice Badge",
        ear1  = "Morion Earring",
        ear2  = "Morion Earring",
        body  = "Seer's Tunic +1",
        hands = "Carbuncle Mitts",
        ring1 = "Ether Ring",
        ring2 = "Astral Ring",
        back  = "Red Cape +1",
        waist = "Adept's Rope",
        legs  = "Seer's Slacks +1",
        feet  = "Mage's Sandals"
    },

    Idle_40 = {
        main  = "Kukulcan's Staff",
        ammo  = "Morion Tathlum",
        head  = "Seer's Crown +1",
        neck  = "Justice Badge",
        ear1  = "Morion Earring",
        ear2  = "Morion Earring",
        body  = "Seer's Tunic +1",
        hands = "Carbuncle Mitts",
        ring1 = "Ether Ring",
        ring2 = "Astral Ring",
        waist = "Adept's Rope",
        legs  = "Seer's Slacks +1",
        feet  = "Mage's Sandals"
    },

    Pet_Idle = {
        body  = "Vermillion Cloak",
        ring2 = "Evoker's Ring",
    },
    
    Pet_Idle_Day = {},
    Pet_Idle_Weather = {},

    Pet_Idle_Carby = {hands = "Carbuncle Mitts"},
    Spirits = {},

    BP = { --I/II cap at 15, max skill afterwards
        head  = "Austere Hat",
        neck  = "Smn. Torque",
        body  = "Austere Robe",
        hands = "Austere Cuffs",
        feet  = "Summoner's Pgch."
    },

	SmnPhysical = { -- Avatar ATK + ACC
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
        legs = "Evoker's Spats",
    },
    
	SmnMagical = { -- Avatar MACC + MATK
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
    },
    
	SmnSkill = { -- Max SMN skill
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
    },
 
    SmnHealing = { -- Avatar HP+, SMN skill
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
    },
    
	SmnEnfeebling = { -- Avatar MACC + SMN skill
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
    },
    
    SmnHybrid = { -- Avatar MATK + ATK 100% Accuracy naturally
        head  = "Evoker's Horn",
        neck  = "Smn. Torque",
        hands = "Austere Cuffs",
        ring2 = "Evoker's Ring",
    },
    
    Precast = {

    },
    
    Precast_Summoning = {

    },

    Midcast = {
        waist = "Heko Obi +1",
    },
    
    Enmity = { --midcast -enmity gear
        head  = "Crow Beret",
        body  = "Crow Jupon",
        hands = "Crow Bracers",
        legs  = "Crow Hose",
        feet  = "Crow Gaiters"
    },

    Cure = {
        neck  = "Justice Badge",
    },
    
    Enhancing = {

    },
    
    Stoneskin = {

    },

    Enfeebling = {
        neck  = "Checkered Scarf",
        body  = "Errant Hpl.",
        hands = "Errant Cuffs",
        legs  = "Errant Slops",
    },

    Enfeebling_MND = {
        neck  = "Justice Badge",
        body  = "Errant Hpl.",
        legs  = "Errant Slops",
        feet  = "Errant Pigaches"
    },
    
	TP = {
        ammo  = "Phtm. Tathlum",
        head  = "",
        neck  = "Uggalepih Pendant",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Vermillion Cloak",
        hands = "Errant Cuffs",
        ring1 = "Ether Ring",
        ring2 = "Evoker's Ring",
        back  = "Summoner's Cape",
        waist = "Hierarch Belt",
        legs  = "Evoker's Spats",
        feet  = "Summoner's Pgch."
    },

    Avatar_TP = {
        ear1  = "Beastly Earring",
        legs  = "Evoker's Spats",
        feet  = "Summoner's Pgch."
    },

	WS = {

    },
    
    SpiritTaker = { -- 50% MND 50% INT 
        head  = "Evoker's Horn",
        neck  = "Justice Badge",
        ear1  = "Phantom Earring",
        ear2  = "Phantom Earring",
        body  = "Errant Hpl.",
        hands = "Errant Cuffs",
        ring1 = "Wisdom Ring",
        ring2 = "Wisdom Ring",
        back  = "Red Cape +1",
        waist = "Mrc.Cpt. Belt",
        legs  = "Seer's Slacks +1",
        feet  = "Summoner's Pgch."
    },

    Retribution = { --30% STR 50% MND 
        head  = "Opo-opo Crown",
        neck  = "Justice Badge",
        body  = "Errant Hpl.",
        legs  = "Errant Slops",
        feet  = "Errant Pigaches"
    },
      
    Resting = {
        main  = DarkStaff,
        head  = "Evoker's Horn",
        neck  = "Checkered Scarf",
        body  = "Errant Hpl.",
        waist = "Hierarch Belt",
        legs  = "Baron's Slops",
    },

	Town = {
        ear1  = "Beastly Earring",
    },
    
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

timerAdded = false;

local function HandlePetAction(PetAction)
	if (includes.SmnSkill:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.SmnSkill);
	elseif (includes.SmnMagical:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.SmnMagical);
    elseif (includes.SmnHybrid:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.SmnHybrid);
	elseif (includes.SmnHealing:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.SmnHealing);
    elseif (includes.SmnEnfeebling:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.SmnEnfeebling);
    else
        gFunc.EquipSet(sets.SmnPhysical);
    end

    if (tTimers == true and timerAdded == false) then
        if (PetAction.Name == 'Shining Ruby') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Shining Ruby" 185');
        elseif (PetAction.Name == 'Earthen Ward') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Earthen Ward" 905');
        elseif (PetAction.Name == 'Spring Water') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Spring Water" 185');
        elseif (PetAction.Name == 'Hastega') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Hastega" 185');
        elseif (PetAction.Name == 'Aerial Armor') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Aerial Armor" 905');
        elseif (PetAction.Name == 'Crimson Roar') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Crimson Roar" 185');
        elseif (PetAction.Name == 'Frost Armor') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Frost Armor" 95');
        elseif (PetAction.Name == 'Sleepga') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Sleepga" 95');
        elseif (PetAction.Name == 'Rolling Thunder') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Rolling Thunder" 65');
        elseif (PetAction.Name == 'Lightning Armor') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Lightning Armor" 95');
        elseif (PetAction.Name == 'Ecliptic Howl') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Ecliptic Howl" 185');
        elseif (PetAction.Name == 'Ecliptic Growl') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Ecliptic Growl" 185');
        elseif (PetAction.Name == 'Dream Shroud') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Dream Shroud" 185');
        elseif (PetAction.Name == 'Noctoshield') then
            AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "Noctoshield" 185');
        end
        timerAdded = true;
    end
end


profile.HandleDefault = function()
    local pet = gData.GetPet();
	local petAction = gData.GetPetAction();
    local environment = gData.GetEnvironment();

    if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    elseif (petAction == nil and timerAdded == true) then
        timerAdded = false;
    end
	
	local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        gFunc.EquipSet( sets.TP);
    elseif (player.Status == 'Resting') then
        if (player.MainJobSync < 40) then
            gFunc.Equip('main', "Pilgrim's Wand");
        elseif (player.MainJobSync < 51) then
            gFunc.Equip('main', "Kukulcan's Staff");
        elseif (player.MainJobSync < 59) then
            gFunc.Equip('body', "Seer's Cloak +1");        
        elseif (player.MainJobSync < 72) then
            gFunc.Equip('body', "Vermillion Cloak");
            gFunc.Equip('head', '');
        end
    else
        if (player.MainJobSync == 50) then
            gFunc.EquipSet(sets.Idle_50);
        elseif (player.MainJobSync == 40) then
            gFunc.EquipSet(sets.Idle_40);
        else
		    gFunc.EquipSet(sets.Idle);
        end
    end

    if (pet ~= nil) then
        gFunc.EquipSet(sets.Pet_Idle);
        
        if (player.HPP <= 75) then
           gFunc.Equip('ring1', "Conjurer's Ring"); 
        end
        
        if (pet.Name == 'Carbuncle' or pet.Name == 'LightSpirit') then
            gFunc.Equip('main', LightStaff)
            if (pet.Name == 'Carbuncle') then
                gFunc.EquipSet(sets.Pet_Idle_Carby);
            end
        elseif (pet.Name == 'Fenrir' or pet.Name == 'DarkSpirit' or pet.Name == 'Diabolos') then
            gFunc.Equip('main', DarkStaff);
        elseif (pet.Name == 'Ifrit' or pet.Name == 'FireSpirit') then
            gFunc.Equip('main', FireStaff);
        elseif (pet.Name == 'Leviathan' or pet.Name == 'WaterSpirit') then
            gFunc.Equip('main', WaterStaff);
        elseif (pet.Name == 'Ramuh' or pet.Name == 'WaterSpirit') then
            gFunc.Equip('main', ThunderStaff);
        elseif (pet.Name == 'Titan' or pet.Name == 'EarthSpirit') then
            gFunc.Equip('main', EarthStaff);
        elseif (pet.Name == 'Garuda' or pet.Name == 'WindSpirit') then
            gFunc.Equip('main', WindStaff);
        elseif (pet.Name == 'Shiva' or pet.Name == 'IceSpirit') then
            gFunc.Equip('main', IceStaff);
        end

        if string.contains(pet.Name, 'Spirit') then
            gFunc.EquipSet(sets.Spirits)
        end

        if (pet.Status == 'Engaged') then
            gFunc.EquipSet(sets.Avatar_TP);
        end
        
        if (avatarElement == environment.DayElement) then
            gFunc.EquipSet(sets.Pet_Idle_Day)
        end

        if (avatarElement == environment.WeatherElement) then
            gFunc.EquipSet(sets.Pet_Idle_Weather)
        end
	end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
	
    includes.RestingCheck(player);
	includes.CheckDefaults();
end

profile.HandleAbility = function()
	local ability = gData.GetAction();
    local pet = gData.GetPet();

    if (ability.Name == 'Release' and pet == nil) then
        gFunc.CancelAction();
        return
    elseif (ability.Name == 'Release') then
        avatarElement = '';
    end

    if (includes.Bloodpacts:contains(ability.Name) and pet ~= nil) then
        gFunc.EquipSet(sets.BP);
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
 
    gFunc.EquipSet(sets.WS);
 
    if (action.Name == "Spirit Taker") then
        gFunc.EquipSet(sets.SpiritTaker);
    elseif (action.Name == "Retribution") then
        gFunc.EquipSet(sets.Retribution);
    end
end

profile.HandleItem = function()
	local item = gData.GetAction();
	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(includes.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast);

    if (spell.Skill == 'Summoning Magic') then
        gFunc.EquipSet(sets.Precast_Summoning);
    end
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

    if (spell.Skill == 'Summoning') then
        gFunc.EquipSet(sets.Midcast);
        avatarElement = spell.Element;            
    elseif (spell.Skill == 'Healing Magic') then
        if player.MPP <= 85 then
            gFunc.EquipSet(sets.Enmity);
        end
        gFunc.EquipSet(sets.Cure);
    elseif (spell.Skill == 'Enfeebling Magic') then
        if (spell.Name == "Paralyze" or spell.Name == "Slow" or spell.Name == "Silence") then
            gFunc.EquipSet(sets.Enfeebling_MND);
        else
            gFunc.EquipSet(sets.Enfeebling);
        end
    end
    
    if (player.MainJobSync >= 51) then
        includes.StaffCheck();
    end

    if string.contains(spell.Name, 'Spirit') then
        gFunc.EquipSet(sets.Spirits)
    end

    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
end

profile.HandleCommand = function(args)
    includes.HandleCommands(args);
end

return profile;
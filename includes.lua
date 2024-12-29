local includes = {};

includes.Craft = false;
includes.Clam = false;
includes.WeaponsLocked = false;
includes.cutsceneSkip = false;
includes.util1 = ''; -- Overwritten by job files
includes.util2 = '';

EarthStaff = "Earth Staff";
WaterStaff = "Neptune's Staff";
WindStaff = "Wind Staff";
FireStaff = "Fire Staff";
IceStaff = "Aquilo's Staff";
ThunderStaff = "Thunder Staff";
LightStaff = "Light Staff";
DarkStaff = "Dark Staff";

includes.elementColors = T{
    dark    = '|cFF919191|Dark|r',
    light   = '|cFFFFFFFF|Light|r',
    fire    = '|cFFDD0000|Fire|r',
    water   = '|cFF0066CC|Water|r',
    thunder = '|cFF9366FA|Thnd.|r',
    earth   = '|cFF8B8B13|Earth|r',
    wind    = '|cFF0BDE27|Wind|r',
    ice     = '|cFF00CCCC|Ice|r',
}

local LockableEquipment = {
    ['Main']  = T{'Warp Cudgel', 'Rep. Signet Staff', 'Kgd. Signet Staff', 'Fed. Signet Staff', 'Treat Staff II', 'Trick Staff II'},
    ['Sub']   = T{},
    ['Range'] = T{},
    ['Ammo']  = T{},
    ['Head']  = T{'Reraise Hairpin', 'Dream Hat +1'},
    ['Neck']  = T{'Opo-opo Necklace'},
    ['Ear1']  = T{'Reraise Earring'},
    ['Ear2']  = T{'Reraise Earring'},
    ['Body']  = T{'Wonder Top +1', 'Mandra. Suit'},
    ['Hands'] = T{},
    ['Ring1'] = T{'Anniversary Ring', 'Emperor Band', 'Chariot Band', 'Empress Band', 'Homing Ring', 'Tavnazian Ring', 'Dem Ring', 'Holla Ring', 'Mea Ring', 'Altep Ring', 'Yhoat Ring'},
    ['Ring2'] = T{'Anniversary Ring', 'Emperor Band', 'Chariot Band', 'Empress Band', 'Homing Ring', 'Tavnazian Ring', 'Dem Ring', 'Holla Ring', 'Mea Ring', 'Altep Ring', 'Yhoat Ring'},
    ['Back']  = T{},
    ['Waist'] = T{},
    ['Legs']  = T{},
    ['Feet']  = T{'Powder Boots'}
}

includes.sets = T{
    Craft = {
        head = "Magnifying Specs.",
    },

    Clam = {
        body  = "Tarutaru Top +1",
        hands = "",
        legs  = "Taru. Shorts +1",
        feet  = ""
    },
};

includes.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Western Adoulin','Eastern Adoulin',
    'Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Windurst Waters [S]',
    'Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Southern San d\'Oria [S]',
    'Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library',
    'Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Bastok Markets [S]'};
includes.Towns.Windurst = T{'Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower'};
includes.Towns.Sandoria = T{'Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille'};
includes.Towns.Bastok = T{'Bastok Mines','Bastok Markets','Port Bastok','Metalworks'};

includes.Bloodpacts = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Spring Water','Ecliptic Growl','Crescent Fang','Eclipse Bite','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing','Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Moonlit Charge','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy','Healing Ruby','Healing Ruby II','Whispering Wind','Flaming Crush','Burning Strike','Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};
includes.SmnSkill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Spring Water','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};
includes.SmnMagical = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'};
includes.SmnHealing = T{'Healing Ruby','Healing Ruby II','Whispering Wind'};
includes.SmnHybrid = T{'Flaming Crush','Burning Strike'};
includes.SmnEnfeebling = T{'Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};

includes.NinNukes = T{'Katon: Ichi', 'Katon: Ni', 'Katon: San', 'Hyoton: Ichi', 'Hyoton: Ni', 'Hyoton: San', 'Huton: Ichi', 'Huton: Ni', 'Huton: San', 'Doton: Ichi', 'Doton: Ni', 'Doton: San', 'Raiton: Ichi', 'Raiton: Ni', 'Raiton: San', 'Suiton: Ichi', 'Suiton: Ni', 'Suiton: San'};

--spell elements for staff handling updated for WHM, BLM, RDM, BRD
includes.Earth = T{'Stone', 'Stone II', 'Stone III', 'Stone IV',
    'Stonega', 'Stonega II', 'Stonega III', 'Quake', 'Rasp',
    'Slow', 'Battlefield Elegy', 'Wind Threnody', 'Carnage Elegy'};
includes.Water = T{'Water', 'Water II', 'Water III', 'Water IV',
    'Waterga', 'Waterga II', 'Waterga III', 'Flood', 'Drown',
    'Poison', 'Poison II', 'Poisonaga', 'Fire Threnody'};
includes.Wind = T{'Aero', 'Aero II', 'Aero III', 'Aero IV',
    'Aeroga', 'Aeroga II', 'Aeroga III', 'Tornado', 'Choke',
    'Gravity', 'Silence', 'Earth Threnody'};
includes.Fire = T{'Fire', 'Fire II', 'Fire III', 'Fire IV',
    'Firaga', 'Firaga II', 'Firaga III', 'Flare', 'Burn',
    'Ice Threnody'};
includes.Ice = T{'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV',
    'Blizzaga', 'Blizzaga II', 'Blizzaga III', 'Freeze', 'Frost',
    'Bind', 'Paralyze', 'Wind Threnody'};
includes.Thunder = T{'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV',
    'Thundaga', 'Thundaga II', 'Thundaga III', 'Burst', 'Shock',
    'Stun', 'Water Threnody'};
includes.Light = T{'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Dia', 'Dia II',
    'Foe Requiem', 'Foe Requiem II', 'Foe Requiem III', 'Foe Requiem IV', 'Foe Requiem V', 'Foe Requiem VI',
    'Foe Lullaby', 'Horde Lullaby', 'Magic Finale'};
includes.Dark = T{'Drain', 'Aspir', 'Bio', 'Bio II', 'Sleep', 'Sleep II', 'Blind'};

function includes.OnLoad()
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /warp /lac fwd warp');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /craft /lac fwd craft');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /clam /lac fwd clam');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /cs /lac fwd cs');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /update /lac fwd update');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /util1 /lac fwd util1');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /util2 /lac fwd util2');
    
    AshitaCore:GetChatManager():QueueCommand(1, '/bind numpad. /lac fwd sjbutton');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind f12 /lac fwd lock');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind pageup /lac fwd util1');
    AshitaCore:GetChatManager():QueueCommand(1, '/bind pagedown /lac fwd util2');
end

function includes.OnUnload()
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /warp');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /craft');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /clam');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /cs');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /update');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /util1');
    AshitaCore:GetChatManager():QueueCommand(1, '/unalias /util2');

    AshitaCore:GetChatManager():QueueCommand(1, '/unbind numpad.');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind f12');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind pageup');
    AshitaCore:GetChatManager():QueueCommand(1, '/unbind pagedown');
    
    if (includes.cutsceneSkip) then 
        AshitaCore:GetChatManager():QueueCommand(1, '/unbind numpad. up');
        AshitaCore:GetChatManager():QueueCommand(1, '/addon unload enternity');
    end
end

function includes.SetTownGear()
	local zone = gData.GetEnvironment();
    if (zone.Area == nil) then return end
	if (includes.Towns:contains(zone.Area)) then gFunc.EquipSet('Town') end
    
    if (includes.Towns.Windurst:contains(zone.Area)) then
        gFunc.Equip('body', 'Federation Aketon')
    elseif (includes.Towns.Sandoria:contains(zone.Area)) then
        gFunc.Equip('body', 'Kingdom Aketon')
    elseif (includes.Towns.Bastok:contains(zone.Area)) then
        gFunc.Equip('body', 'Republic Aketon')
    end
end

function includes.CheckDefaults()
	includes.SetTownGear();    
	if (includes.Clam == true) then gFunc.EquipSet(includes.sets.Clam) end
	if (includes.Craft == true) then gFunc.EquipSet(includes.sets.Craft) end
    
    gFunc.EquipSet(includes.LockedItems(gData.GetEquipment()))
end

function includes.HandleMidcast()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    if (spell.Name == 'Sneak') then
        gFunc.Equip('feet', 'Dream Boots +1');
    elseif (spell.Name == 'Invisible') then
        gFunc.Equip('hands', 'Dream Mittens +1');
    end
end

function includes.HandleCommands(args)
	if (args[1] == 'warp') then
        includes.Warp();
    elseif (args[1] == 'lock') then
        includes.LockWeapons();
    elseif (args[1] == 'craft') then
		includes.Craft = not includes.Craft;
    elseif (args[1] == 'clam') then
		includes.Clam = not includes.Clam;
    elseif (args[1] == 'sjbutton') then
        includes.SJButton();
    elseif (args[1] == 'cs') then
        includes.cutsceneMode();
    elseif (args[1] == 'update') then
        includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet);
    elseif (args[1] == 'util1') then
        if (args[2] == nil and includes.util1 == '') then
            return
        elseif (args[2] == nil and includes.util1 ~= '') then
            AshitaCore:GetChatManager():QueueCommand(1, includes.util1);
        elseif (args[2] ~= nil) then
            if (args[3] ~= nil) then
                includes.util1 = includes.utilBuilder(args[2], args[3]);
            else
                includes.util1 = includes.utilBuilder(args[2]);
            end                
            includes.echoToChat('Util1 updated: now inputting ', includes.util1);
        end
    elseif (args[1] == 'util2') then
        if (args[2] == nil and includes.util2 == '') then
            return
        elseif (args[2] == nil and includes.util2 ~= '') then
            AshitaCore:GetChatManager():QueueCommand(1, includes.util2);
        elseif (args[2] ~= nil) then
            if (args[3] ~= nil) then
                includes.util2 = includes.utilBuilder(args[2], args[3]);
            else
                includes.util2 = includes.utilBuilder(args[2]);
            end                
            includes.echoToChat('Util2 updated: now inputting ', includes.util2);
        end 
    end
end

function includes.UpdateStatus(macroBook, macroSet, util1, util2, lockstyleSet) 
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book ' .. macroBook);
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set ' .. macroSet);

    includes.util1 = includes.utilBuilder(util1);
    includes.util2 = includes.utilBuilder(util2);

    AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset ' .. lockstyleSet);
    (function() AshitaCore:GetChatManager():QueueCommand(1, '/sl blink') end):once(3);
end

function includes.utilBuilder(termOne, termTwo)
    if (termTwo ~= nil) then
        termTwo = ' ' .. termTwo;
    else termTwo = '';
    end
    utilString = '/ma "' .. termOne .. termTwo .. '"';
    return utilString;
end

local restTimer = 0;
local restFirstTick = true;

function includes.RestingCheck(player);
    if (player.Status == 'Resting') then
        if (restFirstTick) then
            restTimer = os.clock() + 16;
            restFirstTick = false;
        end        
        if (os.clock() > restTimer) then
            gFunc.EquipSet('Resting');
        end
    else
        restFirstTick = true;
    end
end

function includes.echoToChat(topic, value)
    gFunc.Echo(73, '## ' .. topic .. value .. ' ##');
end

function includes.Warp() -- May delete, just shortcuts/automates warping, kind of unneeded
    local player = gData.GetPlayer();
    
    if (player.MainJob == "BLM" or player.SubJob == "BLM") then
        AshitaCore:GetChatManager():QueueCommand(-1, '/ma "Warp" <me>');
        return
    else
        includes.WeaponsLocked = false;
        AshitaCore:GetChatManager():QueueCommand(-1, '/equip main "Warp Cudgel"');
        local function usecudgel()
            AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Cudgel" <me>');
        end
        local function removeCudgel()
            AshitaCore:GetChatManager():QueueCommand(1, '/equip main');
        end
        usecudgel:once(31);
        removeCudgel:once(42);
    end
end

function includes.StaffCheck() -- Better way to do this but I wrote it and don't wanna get rid of my baby~ >:3
    local spell = gData.GetAction();
    
    if (includes.Earth:contains(spell.Name)) then
        gFunc.Equip('main', EarthStaff);
    elseif (includes.Water:contains(spell.Name)) then
        gFunc.Equip('main', WaterStaff);
    elseif (includes.Wind:contains(spell.Name)) then
        gFunc.Equip('main', WindStaff);
    elseif (includes.Fire:contains(spell.Name)) then
        gFunc.Equip('main', FireStaff);
    elseif (includes.Ice:contains(spell.Name)) then
        gFunc.Equip('main', IceStaff);
    elseif (includes.Thunder:contains(spell.Name)) then
        gFunc.Equip('main', ThunderStaff);
    elseif (includes.Light:contains(spell.Name)) then
        gFunc.Equip('main', LightStaff);
    elseif (includes.Dark:contains(spell.Name)) then
        gFunc.Equip('main', DarkStaff);
    end
end

function includes.LockWeapons()
    includes.WeaponsLocked = not includes.WeaponsLocked;
    local player = gData.GetPlayer();

    if (includes.WeaponsLocked == true) then
        gFunc.Disable(1);
        gFunc.Disable(2);
        if player.MainJob ~= 'BRD' then
            gFunc.Disable(3);
        end        
    else
        gFunc.Enable(1);
        gFunc.Enable(2);
        if player.MainJob ~= 'BRD' then
            gFunc.Enable(3);
        end        
    end
end

function includes.LockedItems(equipment)
    local player = gData.GetPlayer();
    local lockableSet = {};

    for slot, item in pairs(equipment) do
        if (LockableEquipment[slot]:contains(item.Name)) then
            lockableSet[slot] = item;
            if (item.Name == 'Wonder Top +1') then
                lockableSet['Hands'] = '';
            elseif (item.Name == 'Mandra. Suit') then
                lockableSet['Legs'] = '';
            elseif (slot == 'Main') then
                lockableSet['Sub'] = '';
            end
        end
    end

    return lockableSet
end

function includes.cutsceneMode()
    includes.cutsceneSkip = not includes.cutsceneSkip;

    if (includes.cutsceneSkip == true) then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind numpad. /fps 0');
        AshitaCore:GetChatManager():QueueCommand(1, '/bind numpad. up /fps 1');
        AshitaCore:GetChatManager():QueueCommand(1, '/addon load enternity');
    elseif (includes.cutsceneSkip == false) then
        AshitaCore:GetChatManager():QueueCommand(1, '/bind numpad. /lac fwd sjbutton');
        AshitaCore:GetChatManager():QueueCommand(1, '/unbind numpad. up');
        AshitaCore:GetChatManager():QueueCommand(1, '/addon unload enternity');
    end
end

function includes.SJButton()
    local player = gData.GetPlayer();
    local utsuNi = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(339);

    
    if (player.SubJob == 'NIN') then
        if (player.MainJobSync >= 74 and utsuNi == 0) then
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Utsusemi: Ni" <me>');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/ma "Utsusemi: Ichi" <me>');
        end
    else
        includes.echoToChat('No command configured for subjob: ', player.SubJob .. '.');
    end
end

return includes;
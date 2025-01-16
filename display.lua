local Cycles = {};
local Toggles = {};
local fonts = require('fonts')

local display = {}

local player = gData.GetPlayer();
local header = '    ---  ' .. player.MainJobSync .. player.MainJob .. '/' .. player.SubJobSync .. player.SubJob .. '  ---    ';

local fontSettings = T{
    visible = true,
    font_family = 'Consolas',
    font_height = 12,
    color = 0xFFD6D6D6,
    position_x = 840, -- Distance from left of screen
    position_y = 1214,-- Distance from top of screen
    background = T{
        visible = true,
        color = 0x80000000,
    },
}

function display.AdvanceCycle(name)
    local ctable = Cycles[name];
    if (type(ctable) ~= 'table') then
        return;
    end

    ctable.Index = ctable.Index + 1;
    if (ctable.Index > #ctable.Array) then
        ctable.Index = 1;
    end
end

function display.AdvanceCycleBack(name)
    local ctable = Cycles[name];
    if (type(ctable) ~= 'table') then
        return;
    end

    ctable.Index = ctable.Index - 1;
    if (ctable.Index == 0) then
        ctable.Index = #ctable.Array;
    end
end

function display.AdvanceToggle(name)
    if (type(Toggles[name]) ~= 'boolean') then
        return
    elseif Toggles[name] then
        Toggles[name] = false;
    else
        Toggles[name] = true;
    end
end

--name must be a valid lua variable name in string format.
--default must be a boolean
function display.CreateToggle(name, default)
    Toggles[name] = default;
end

--name must be a valid lua variable name in string format.
--values must be an array style table containing only strings mapped to sequential indices.
--first value in table will be default.
function display.CreateCycle(name, values)
    local newCycle = {
        Index = 1,
        Array = values
    };
    Cycles[name] = newCycle;
end

function display.GetCycle(name)
    local ctable = Cycles[name];
    if (type(ctable) == 'table') then
        return ctable.Array[ctable.Index];
    else
        return 'Unknown';
    end
end

function display.GetToggle(name)
    if (Toggles[name] ~= nil) then
        return Toggles[name];
    else
        return false;
    end
end

display.Unload = function()
	if (display.FontObject ~= nil) then
		display.FontObject:destroy();
	end
	ashita.events.unregister('d3d_present', 'display_present_cb');
end

display.Load = function()
    display.FontObject = fonts.new(fontSettings);
    
	ashita.events.register('d3d_present', 'display_present_cb', function ()
        local player = gData.GetPlayer();
        local outText = '    ---  ' .. includes.job .. '  ---    ';

        if (jobText ~= '') then
            outText = outText .. '\n ' .. jobText;
        end

        for key, value in pairs(Cycles) do
                outText = outText .. '\n ' .. key .. ': ' .. '|cFF0BDE27|' .. value.Array[value.Index] .. '|r';
        end

		for key, value in pairs(Toggles) do
            outText = outText .. '\n ' .. key .. ': ';
			if (value == true) then
				outText = outText .. '|cFF0BDE27|Enabled|r';
			else
				outText = outText .. '|cFFDD0000|Disabled|r';
			end
		end

        if (includes.util1 ~= '/ma ""' or includes.util2 ~= '/ma ""') then
            outText = outText .. '\n    --- === Utils === ---    ';
            if (includes.util1 ~= '/ma ""' and includes.util1 ~= '') then
                local util1Str = string.upper(string.sub(includes.util1, 6, 6)) .. string.lower(string.sub(includes.util1, 7, string.len(includes.util1) - 1))
                outText = outText .. '\n 1: ' .. util1Str;
            end
            if (includes.util2 ~= '/ma ""' and includes.util2 ~= '') then
                local util2Str = string.upper(string.sub(includes.util2, 6, 6)) .. string.lower(string.sub(includes.util2, 7, string.len(includes.util2) - 1));
                outText = outText .. '\n 2: ' .. util2Str;
            end
        end

		display.FontObject.text = outText;
	end)
end

return display;

local Cycles = {};
local Toggles = {};
local fonts = require('fonts')

local display = {
}

local fontSettings = T{
    visible = true,
    font_family = 'Consolas',
    font_height = 12,
    color = 0xFFD6D6D6,
    position_x = 840, -- Distance from left of screen
    position_y = 1300,-- Distance from top of screen
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
    local player = gData.GetPlayer();

	ashita.events.register('d3d_present', 'display_present_cb', function ()
		local outText = '    ---  ' .. player.MainJobSync .. player.MainJob .. '/' .. player.SubJobSync .. player.SubJob .. '  ---    ';
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
				outText = outText .. '|cFFCC0000|Disabled|r';
			end
		end

		display.FontObject.text = outText;
	end)
end

return display;

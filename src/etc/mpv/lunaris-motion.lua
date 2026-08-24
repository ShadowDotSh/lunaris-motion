local menu_open = false
local selected = 1
local script_path = "/usr/bin/lunaris-motion"

-- Commands list
local items = {
	{ label = "Workshop", flag = "-w" },
	{ label = "Restore", flag = "-r" },
	{ label = "Daemonless", flag = "-d" },
	{ label = "Resume", flag = "--play" },
	{ label = "Pause", flag = "--pause" },
	{ label = "Kill", flag = "-k" },
}

-- Execute bash script asynchronously
local function run_lunaris(flag)
	mp.command_native_async({
		name = "subprocess",
		args = { script_path, flag },
		playback_only = false,
		capture_stdout = false,
		capture_stderr = false,
	}, function() end)
end

-- OSD menu
local function draw_menu()
	if not menu_open then
		mp.set_osd_ass(0, 0, "")
		return
	end

	-- Catppuccin Mocha Palette
	local base = "&H002E1E1E&" -- #1e1e2e (Base)
	local crust = "&H001B1111&" -- #11111b (Crust / Shadow)
	local text = "&H00F4D6CD&" -- #cdd6f4 (Text)
	local blue = "&H00FAB489&" -- #89b4fa (Blue Accent)
	local subtext = "&H00C8ADA6&" -- #a6adc8 (Subtext0)

	-- Base styling
	local ass = "{\\an7\\fs8\\bord1\\shad2\\3c" .. crust .. "\\4c" .. crust .. "}\\N\\N"

	-- Header
	ass = ass .. "{\\b1\\c" .. blue .. "}  Lunaris Motion{\\b0\\c" .. text .. "}\\N\\N"

	-- Menu Items
	for i, item in ipairs(items) do
		if i == selected then
			-- Selected item gets the accent and bold text
			ass = ass .. "{\\c" .. blue .. "\\b1}▸ " .. item.label .. "{\\b0}\\N"
		else
			-- Normal items use the Text color
			ass = ass .. "{\\c" .. text .. "}  " .. item.label .. "\\N"
		end
	end

	-- Footer
	ass = ass .. "\\N{\\fs6\\c" .. subtext .. "}Right-Click: Open/Close  |  Scroll: Navigate  |  Left-Click: Select"

	mp.set_osd_ass(0, 0, ass)
end

local function toggle_menu()
	menu_open = not menu_open
	if menu_open then
		selected = 1
	end
	draw_menu()
end

local function nav(dir)
	if not menu_open then
		return
	end
	selected = selected + dir
	if selected < 1 then
		selected = #items
	end
	if selected > #items then
		selected = 1
	end
	draw_menu()
end

local function select_item()
	if not menu_open then
		return
	end
	local chosen_flag = items[selected].flag
	menu_open = false
	draw_menu()

	mp.osd_message("Run: lunaris-motion " .. chosen_flag, 2)
	run_lunaris(chosen_flag)
end

-- ==========================================
-- FORCED MOUSE-ONLY KEYBINDINGS
-- ==========================================
-- We use add_forced_key_binding so mpv doesn't drop the events
-- when --input-default-bindings=no is active!

mp.add_forced_key_binding("mbtn_right", "lunaris-menu-toggle", toggle_menu)
mp.add_forced_key_binding("wheel_up", "lunaris-menu-up", function()
	nav(-1)
end)
mp.add_forced_key_binding("wheel_down", "lunaris-menu-down", function()
	nav(1)
end)
mp.add_forced_key_binding("mbtn_left", "lunaris-menu-select", select_item)

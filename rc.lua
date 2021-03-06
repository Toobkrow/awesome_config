-- Library includings {{{
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--freedesktop menu
require('freedesktop.utils')
require('freedesktop.menu')
--widget library
--require("vicious")

-- }}}

-- Variable definitions {{{
	-- Themes define colours, icons, and wallpapers
	beautiful.init( awful.util.getdir("config") .. "/theme/theme.lua")

	-- This is used as the default terminal and editor to run.
	terminal = "xterm"

	-- Default modkey.
	-- Mod4 is the key with a logo between Control and Alt.
	modkey = "Mod4"

	-- Table of layouts to cover with awful.layout.inc, order matters.
	layouts =
	{
		awful.layout.suit.tile,
		awful.layout.suit.floating
	}

	-- we only have one screen and use this variable to call it
	-- to clearify that the screennumber is ment
	myscreen = 1

-- }}}

-- Tags {{{
	-- Define a tag table which hold all screen tags. We only have one screen.
	tags = {}
	tags[myscreen]=awful.tag({"term","web","mail"}, s, layouts[1])
-- }}}

-- Menu {{{
	freedesktop.utils.terminal = terminal
	freedesktop.utils.icon_theme = 'oxygen'
	freedesktopmenu = freedesktop.menu.new()
	menu_items = {}

	-- remove all the top-menu icons
	while(freedesktopmenu[1]) do
		table.insert(menu_items, {freedesktopmenu[1][1], freedesktopmenu[1][2]})
		table.remove(freedesktopmenu, 1)
		end

	myquitmenu = {
		{"lock screen", "slock" },
		--{"suspend", "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Suspend"},
		--{"hibernate", "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate"},
		--{"reboot", "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart"},
		{"reboot", "sudo reboot"},
		--{"shutdown", "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"}
		{"shutdown", "sudo shutdown -h now"}
	}

	table.insert(menu_items, 1, {" "," "})
	table.insert(menu_items, 1, {"monitor-settings", "lxrandr"})
	table.insert(menu_items, 1, {"files", "pcmanfm"})
	table.insert(menu_items, 1, {"mail", "thunderbird"})
	table.insert(menu_items, 1, {"www", "firefox"})
	table.insert(menu_items, {"",""})
	table.insert(menu_items, {"leave", myquitmenu})
	--menu_items = {
		--{"www", "firefox"},
		--{"mail", "thunderbird"},
		--{"files", "pcmanfm"},
		--{"monitor-settings", "lxrandr"},
		--{"apps", myapplicationsmenu},
		--{"leave", myquitmenu}
	--}
	mymainmenu = awful.menu.new({items = menu_items, width = 150})

-- }}}

-- Widgets {{{
	-- Create a textclock widget
	mytextclock = awful.widget.textclock({align = "right"}, "%H:%M, %b %d")


	-- Create a systray
	mysystray = widget({type = "systray"})


	-- Create a battery status widget
--	mybat = widget({type = "textbox"})
--	vicious.register(mybat, vicious.widgets.bat,
--		function (widget, args)
--			-- check if battery is in slot
--			if (args[2] == 0) then
--				return ''
--			else
--				return 'battery['.. args[2] .. '% ' .. args[1] .. args[3] .. '] '
--			end
--		end, 10, "BAT1")


	-- Create a taglist widget
	mytaglist = {}
	mytaglist.buttons = awful.util.table.join(
		awful.button({}, 1, awful.tag.viewonly),
		awful.button({modkey}, 1, awful.client.movetotag),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({modkey}, 3, awful.client.toggletag),
		awful.button({}, 4, awful.tag.viewnext),
		awful.button({}, 5, awful.tag.viewprev)
	)
	mytaglist = awful.widget.taglist(myscreen, awful.widget.taglist.label.all, mytaglist.buttons)


	-- Create a tasklist widget
	mytasklist = {}
	mytasklist.buttons = awful.util.table.join(
		awful.button({}, 1, function (c)
			if not (c == client.focus) then
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
				client.focus = c
				c:raise()
			end
		end),
		awful.button({}, 3, function ()
				mymainmenu:toggle()
		end)
	)
	mytasklist = awful.widget.tasklist(function(c)
		--little wraparound to remove tasklist-icon
		--	without modifying the original tasklist.lua
		local tmptask = { awful.widget.tasklist.label.currenttags(c, myscreen) }
		return tmptask[1], tmptask[2], tmptask[3], nil
	end, mytasklist.buttons)

	-- Create a promptbox for each screen
	mypromptbox = awful.widget.prompt({layout = awful.widget.layout.horizontal.leftright})

-- }}}

-- Wibox {{{

	mywibox = {}
	mywibox = awful.wibox({position = "top", screen = myscreen, height=12})
	-- Add widgets to the wibox - order matters
	mywibox.widgets = {
		--we divide the widgets in two parts to make the tasklist expand
		{
			mytaglist,
			mypromptbox,
			layout = awful.widget.layout.horizontal.leftright
		},
		mytextclock,
--		mybat,
		mysystray,
		mytasklist,
		layout = awful.widget.layout.horizontal.rightleft
	}
-- }}}

-- Mouse bindings for empty desktop space {{{
	root.buttons(
		awful.util.table.join(
			awful.button({}, 3, function ()
				mymainmenu:toggle()
			end),
			awful.button({}, 4, awful.tag.viewnext),
			awful.button({}, 5, awful.tag.viewprev)
		)
	)
-- }}}

-- Key bindings {{{
	globalkeys = awful.util.table.join(
		-- next tag
		awful.key({modkey}, "h", function ()
			awful.tag.viewprev()
		end),

		-- previous tag
		awful.key({modkey}, "l", function ()
			awful.tag.viewnext()
		end),

		-- next window
		awful.key({modkey}, "k", function ()
			awful.client.focus.byidx( 1)
			if client.focus then
				client.focus:raise()
			end
		end),

		-- previous window
		awful.key({modkey}, "j", function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end),

		-- previously used window
		awful.key({modkey}, "Tab", function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end),

		-- Layout manipulation
		-- set focussed window as master of this tag
		awful.key({modkey}, "s", function ()
			while not(awful.client.idx(c).col == 0) do
				awful.client.swap.byidx(1)
			end
		end),

		-- change horizontal size
		awful.key({modkey}, "i", function ()
			awful.tag.incmwfact( 0.05)
		end),

		awful.key({modkey}, "u", function ()
			awful.tag.incmwfact(-0.05)
		end),

		-- show menu
		awful.key({modkey}, "w", function ()
			mymainmenu:show({keygrabber = true})
		end),

		-- run program prompt
		awful.key({modkey}, "r", function ()
			mypromptbox:run()
		end),

		-- advanced desktop functionalitay
		awful.key({modkey}, "Return", function ()
			awful.util.spawn(terminal)
		end),

		awful.key({}, "XF86AudioPlay", function ()
			awful.util.spawn("nyxmms2 toggle")
		end),

		awful.key({}, "XF86AudioNext", function ()
			awful.util.spawn("nyxmms2 next")
		end),

		awful.key({}, "XF86AudioPrev", function ()
			awful.util.spawn("nyxmms2 prev")
		end),

		awful.key({}, "XF86AudioRaiseVolume", function ()
			awful.util.spawn("amixer sset Master 2dB+")
		end),

		awful.key({}, "XF86AudioLowerVolume", function ()
			awful.util.spawn("amixer sset Master 2dB-")
		end),

		awful.key({}, "XF86AudioMute", function ()
			awful.util.spawn("amixer set Master toggle")
		end),

		awful.key({modkey}, "Escape", function ()
			awful.util.spawn("slock")
		end),

		awful.key({modkey, "Shift"}, "r", awesome.restart)
	)

	clientkeys = awful.util.table.join(
		awful.key({modkey}, "f", function (c)
			c.fullscreen = not c.fullscreen
		end),

		awful.key({modkey}, "c", function (c)
			c:kill()
		end),

		awful.key({modkey}, "q", function (c)
			c:kill()
		end),

		--toggle floating
		awful.key({modkey}, "space", function (c)
			if c.maximized_horizontal and c.maximized_vertical then
				c.maximized_horizontal = false
				c.maximized_vertical = false
			else
				awful.client.floating.toggle(c)
			end
		end),

		-- toggle maximized
		awful.key({modkey}, "m", function (c)
			if not c.maximized_horizontal then
				awful.client.floating.set(c, true)
				c.maximized_horizontal = true
				c.maximized_vertical = true
			else
				awful.client.floating.set(c, false)
				c.maximized_horizontal = false
				c.maximized_vertical = false
			end
		end)
	)

	-- Bind all key numbers to tags.
	-- Compute the maximum number of digit we need, limited to 9
	keynumber = 0
	keynumber = math.min(9, math.max(#tags[myscreen], keynumber));
	-- Be careful: we use keycodes to make it works on any keyboard layout.
	-- This should map on the top row of your keyboard, usually 1 to 9.
	for i = 1, keynumber do
		globalkeys = awful.util.table.join(globalkeys,
			-- switch to tag number
			awful.key({modkey}, "#" .. i + 9, function ()
				if tags[myscreen][i] then
					awful.tag.viewonly(tags[myscreen][i])
				end
			end),

			-- move focussed window to tag
			awful.key({modkey, "Shift"}, "#" .. i + 9, function ()
				if client.focus and tags[myscreen][i] then
					awful.client.movetotag(tags[myscreen][i])
				end
			end)
		)
	end

	clientbuttons = awful.util.table.join(
		awful.button({}, 1, function (c)
			client.focus = c
			c:raise()
		end),
		awful.button({modkey}, 1, awful.mouse.client.move),
		awful.button({modkey}, 3, awful.mouse.client.resize)
	)

	-- Set keys
	root.keys(globalkeys)
-- }}}

-- Rules {{{

		floatingList = {
			"Pidgin",
			"Wicd",
			"Skype",
			"Pavucontrol",
			"recordMyDesktop"
		}

		tagTermList = {
			"XTerm",
			"URxvt"
		}

		tagWebList = {
			"Firefox",
			"Chromium",
			"Uzbl"
		}

		tagMailList = {
			"Thunderbird",
			"Claws",
			"Pidgin",
			"Skype"
		}

	awful.rules.rules = {
		-- All clients will match this rule.
		{rule = {}, properties =
			{
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = true,
				buttons = clientbuttons,
				keys = clientkeys
			}
		},

		{ rule_any = { class = floatingList }, properties = { floating = true } },
		-- no tiling for i.e. youtube video fullscreen
		{ rule = { instance = "plugin-container" },	properties = { floating = true } },

		{ rule_any = { class = tagTermList }, properties = { tag = tags[myscreen][1] } },
		{ rule_any = { class = tagWebList }, properties = { tag = tags[myscreen][2] } },
		{ rule_any = { class = tagMailList }, properties = { tag = tags[myscreen][3] } }

	}
-- }}}

-- Signals {{{
	-- Signal function to execute when a new client appears.
	client.add_signal("manage", function (c, startup)
		-- Put windows in a smart way, only if they does not set an initial position.
		if not startup then
			if not c.size_hints.user_position
			and not c.size_hints.program_position then
				awful.placement.no_overlap(c)
				awful.placement.no_offscreen(c)
			end
		end
		--remove gaps between windows
		c.size_hints_honor = false
		--to keep left window position set new window as slave
		awful.client.setslave(c)
	end)

	client.add_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.add_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
-- }}}

-- Autostart programs {{{
	do
		-- set capslock key as escape key
		awful.util.spawn_with_shell("xmodmap /home/daniel/.Xmodmap")
		-- no more autoblanking screen
		awful.util.spawn_with_shell("xset -dpms")
		awful.util.spawn_with_shell("xset s off")
		-- no annoying beep sounds in applications
		awful.util.spawn_with_shell("xset b off")
		-- apply settings in .Xresources
		awful.util.spawn_with_shell("xrdb -load .Xresources")
		-- no touchpad
		awful.util.spawn_with_shell("synclient TouchpadOff=1")

		-- no more problem with java applications
		awful.util.spawn_with_shell("wmname LG3D")
	end
-- }}}

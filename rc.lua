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
require("vicious")

-- Variable definitions {{{
	-- Themes define colours, icons, and wallpapers
	beautiful.init( awful.util.getdir("config") .. "/themes/default/theme.lua")

	-- This is used as the default terminal and editor to run.
	terminal = "sakura"
	editor = "gvim"
	filemanager = "pcmanfm"
	webbrowser = "firefox"
	onlineappbrowser = "uzbl-browser "

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
	-- TODO try out shifty and eminent for dynamic tagging
	tags = {}
	tags[myscreen]=awful.tag({"web","msg","fm","dev","msc"}, s, layouts[1])
-- }}}

-- Menu {{{
	freedesktop.utils.terminal = terminal
	freedesktop.utils.icon_theme = 'gnome'
	myapplicationsmenu = freedesktop.menu.new()

	myawesomemenu = {
		{"manual", terminal .. " -e man awesome"},
		{"edit config", editor .. " " .. awful.util.getdir("config") .. "/rc.lua"},
		{"restart", awesome.restart},
		{"quit", awesome.quit}
	}

	myquitmenu = {
		{"lock screen", "xscreensaver-command -lock" },
		{"suspend", "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Suspend"},
		{"hibernate", "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate"},
		{"reboot", "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart"},
		{"shutdown", "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"}
	}

	myonlinemenu = {
		{"rainymood", webbrowser .. " rainymood.com"},
		{"grooveshark", onlineappbrowser .. "grooveshark.com"},
		{"zeit", onlineappbrowser .. "zeit.de"},
		{"arte", onlineappbrowser .. "arte.tv/de"},
		{"Uzbl", "uzbl-tabbed"}
	}

	menu_items = {
		{"webbrowser", webbrowser},
		{"mail", "thunderbird"},
		{"music", "etude"},
		{"instant messenger", "pidgin"},
		{"file manager", filemanager},
		{" "},
		{"online", myonlinemenu},
		{"applications", myapplicationsmenu},
		{"awesome", myawesomemenu, image(beautiful.awesome_icon)},
		{" "},
		{"Quit", myquitmenu}
	}
	mymainmenu = awful.menu.new({items = menu_items, width = 150})

	mymenulauncher = awful.widget.launcher({image = image(beautiful.awesome_icon), menu = mymainmenu})
-- }}}

-- Widgets {{{
	-- Create a textclock widget
	mytextclock = awful.widget.textclock({align = "right"})

	-- Create a systray
	mysystray = widget({type = "systray"})

	-- Create a battery status widget
	mybat = widget({type = "textbox"})
	vicious.register(mybat, vicious.widgets.bat, " [ $2% $1 $3 ] ", 10, "BAT1")

	mytaglist = {}
	mytaglist.buttons = awful.util.table.join(
		awful.button({}, 1, awful.tag.viewonly),
		awful.button({ modkey }, 1, awful.client.movetotag),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({modkey}, 3, awful.client.toggletag),
		awful.button({}, 4, awful.tag.viewnext),
		awful.button({}, 5, awful.tag.viewprev)
	)
	mytasklist = {}
	mytasklist.buttons = awful.util.table.join(
		awful.button({}, 1, function (c)
			if c == client.focus then
				c.minimized = true
			else
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
				-- This will also un-minimize the client, if needed
				client.focus = c
				c:raise()
			end
		end),
		awful.button({}, 3, function ()
			if instance then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ width=250 })
			end
		end),
		awful.button({}, 4, function ()
			awful.client.focus.byidx(1)
			if client.focus then client.focus:raise() end
		end),
		awful.button({}, 5, function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end)
	)
-- }}}

-- Wibox {{{
	-- Create a promptbox for each screen
	mypromptbox = awful.widget.prompt({layout = awful.widget.layout.horizontal.leftright})

	-- Create a taglist widget
	mytaglist = awful.widget.taglist(myscreen, awful.widget.taglist.label.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist = awful.widget.tasklist(function(c)
		--little wraparound to remove tasklist-icon
		--  without modifying the original tasklist.lua
		local tmptask = { awful.widget.tasklist.label.currenttags(c, myscreen) }
		return tmptask[1], tmptask[2], tmptask[3], nil
	end, mytasklist.buttons)

	mywibox = {}
	mywibox = awful.wibox({position = "top", screen = myscreen})
	-- Add widgets to the wibox - order matters
	mywibox.widgets = {
		--we divide the widgets in two parts to make the tasklist expand
		{
			mytaglist,
			mypromptbox,
			layout = awful.widget.layout.horizontal.leftright
		},
		mytextclock,
		mybat,
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
		awful.key({modkey,}, "h", function () 
			awful.tag.viewprev()
		end), 

		-- previous tag
		awful.key({modkey,}, "l", function ()
			awful.tag.viewnext()
		end),

		-- next window
		awful.key({modkey,}, "k", function ()
			awful.client.focus.byidx( 1)
			if client.focus then
				client.focus:raise()
			end
		end),

		-- previous window
		awful.key({modkey,}, "j", function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end),

		-- previously used window
		awful.key({modkey,}, "Tab", function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end),

		-- restore minimized window
		awful.key({modkey, "Shift"}, "n", awful.client.restore), 

		-- Layout manipulation
		-- move position of focussed window
		awful.key({modkey,}, "i", function ()
			awful.client.swap.byidx(1)
		end),
		awful.key({modkey,}, "u", function ()
			awful.client.swap.byidx(-1)
		end),
		-- change horizontal size
		awful.key({modkey, "Shift"}, "i", function ()
			awful.tag.incmwfact( 0.05)
		end), 
		awful.key({modkey, "Shift"}, "u", function ()
			awful.tag.incmwfact(-0.05)
		end),
		-- staple windows vertically
		awful.key({modkey, "Control"}, "i", function ()
			awful.tag.incnmaster(1)
		end), 
		awful.key({modkey, "Control"}, "u", function ()
			awful.tag.incnmaster(-1)
		end),

		-- show menu
		awful.key({modkey,}, "w", function ()
			mymainmenu:show({keygrabber = true})
		end),

		-- run program prompt
		awful.key({modkey}, "r", function ()
			mypromptbox:run()
		end),

		-- advanced desktop functionalitay
		awful.key({ modkey,}, "Return", function ()
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
		awful.key({modkey,}, "Escape", function ()
			awful.util.spawn("slock")
		end),
		awful.key({modkey, "Control"}, "r", awesome.restart)
	)

	clientkeys = awful.util.table.join(
		awful.key({ modkey,}, "f", function (c)
			c.fullscreen = not c.fullscreen
		end),
		awful.key({modkey,}, "c", function (c)
			c:kill()
		end),

		--toggle floating
		awful.key({modkey,}, "space", function (c)
			awful.client.floating.toggle(c)     
		end),

		--minimize
		awful.key({modkey,}, "n", function (c)
			c.minimized = true
		end),

		-- toggle maximized
		awful.key({modkey,}, "m", function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
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
			awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
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
		{rule = {class = "gimp"}, properties =
			{
				floating = true,
				tag = tags[myscreen][5]
			}
		},
		{rule = {class = "Firefox"}, properties =
			{
				tag = tags[myscreen][1]
			}
		},
		{rule = {class = "Uzbl"}, properties =
			{
				tag = tags[myscreen][1],
			}
		},
		{rule = {class = "Chromium"}, properties =
			{
				tag = tags[myscreen][1]
			}
		},
		{rule = {class = "Thunderbird"}, properties =
			{
				tag = tags[myscreen][2]
			}
		},
		{rule = {class = "Claws"}, properties =
			{
				tag = tags[myscreen][2]
			}
		},
		{rule = {class = "Pcmanfm"}, properties =
			{
				tag = tags[myscreen][3]
			}
		},
		{rule = {class = "Pidgin" }, properties =
			{
				floating = true,
				tag = tags[myscreen][2]
			}
		},
		{rule = {class = "Wicd"}, properties =
			{
				floating = true
			}
		},
		{rule = {class = "Etude"}, properties =
			{
				tag = tags[myscreen][5]
			}
		},
		{rule = {class = "Gvim"}, properties =
			{
				tag = tags[myscreen][4]
			}
		}
	}
-- }}}

-- Signals {{{
	-- Signal function to execute when a new client appears.
	client.add_signal("manage", function (c, startup)
		-- Enable sloppy focus
		c:add_signal("mouse::enter", function(c)
			if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier 
			and awful.client.focus.filter(c) then
				client.focus = c
			end
		end)
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
	end)

	client.add_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.add_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
-- }}}

-- Autostart programs {{{
--	function run_once(prg)
--		awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
--	end

	do
		-- do not use touchpad
		awful.util.spawn_with_shell("synclient TouchpadOff=1")
		-- set capslock key as escape key
		awful.util.spawn_with_shell("xmodmap /home/daniel/.Xmodmap")
		-- no annoying beep sounds in applications
		awful.util.spawn_with_shell("xset b off")
--		local cmds = 
--		{ 
--		}
--		for _,i in pairs(cmds) do
--			run_once(i)
--		end
	end
-- }}}

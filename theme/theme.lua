theme = {}

theme.font          = "terminus 9"

theme.bg_normal     = "#000000"
--theme.bg_focus      = "#99BBFF"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#aa0000"
theme.bg_minimize   = "#aa0000"

theme.fg_normal 	= "#888888"
theme.fg_focus 		= "#dd7500"
theme.fg_urgent   = "#000000"
theme.fg_minimize   = theme.fg_normal

theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_border_width = "1"
theme.menu_border_color = theme.bg_focus

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -a '/home/daniel/.config/awesome/theme/wallpaper.jpg'" }

return theme

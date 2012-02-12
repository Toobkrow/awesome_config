theme = {}

theme.font          = "monospace 8"

theme.bg_normal     = "#293C42"
theme.bg_focus      = "#ccaaff"
theme.bg_urgent     = "#aa0000"
theme.bg_minimize   = "#aa0000"

theme.fg_normal 	= "#ffffff"
theme.fg_focus 		= "#000000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = theme.fg_normal

theme.border_width  = "4"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_border_width = "0"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -f '/home/daniel/.config/awesome/theme/wallpaper.jpg'" }

return theme

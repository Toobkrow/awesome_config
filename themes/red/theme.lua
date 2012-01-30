---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "monospace 8"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#aa0000"
theme.bg_minimize   = "#222222"

theme.fg_normal 	= "#444444"
theme.fg_focus 		= "#aa0000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = theme.fg_normal

theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.fg_focus
theme.border_marked = theme.bg_urgent

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
--theme.menu_height = "15"
--theme.menu_width  = "100"
theme.menu_border_color = theme.bg_minimize
theme.menu_border_width = "1"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -f '/home/daniel/Bilder/Wallpapers/Landscape & Nature/wallpaper-1526947.jpg'" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/zenburn/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/zenburn/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/zenburn/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/zenburn/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/zenburn/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/zenburn/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/zenburn/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/zenburn/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/zenburn/layouts/dwindlew.png"

theme.menu_icon = "/home/daniel/.icons/emblem-arch.png"
theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"


return theme
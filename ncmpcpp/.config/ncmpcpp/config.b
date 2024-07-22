[ncmpcpp]
ncmpcpp_directory                           = ~/.config/ncmpcpp

[mpd]
mpd_connection_timeout                      = 5
mpd_crossfade_time                          = 2
mpd_host                                    = 127.0.0.1
mpd_music_dir                               = ~/Music
mpd_port                                    = 6605

[visualizer]
visualizer_in_stereo                        = yes
visualizer_fps                              = 60
visualizer_type                             = ellipse 
visualizer_data_source                      = /tmp/mpd.fifo
visualizer_output_name                      = mpd_visualizer
visualizer_color                            = 33,39,63,75,81,99,117,153,189
visualizer_look                             = ●●
visualizer_spectrum_smooth_look             = yes

[library]
#song_library_format                         = "{{%a - %t}|{%f}}{$R%l}"
empty_tag_color                             = black
#current_item_prefix                         = "$(yellow)$r"
#current_item_suffix                         = "$/r$(end)"
# song_list_format                          = "{$8%a ⠂ }{%t}|{%f}$R{%l}"
#song_list_format                            = "{{%a - %t}|{%f}}{$R%l}"

[playlist]
playlist_display_mode                       = columns
#song_columns_list_format                    = "(50)[yellow]{ar} (50)[white]{t}"
now_playing_prefix = "$b$2$7 "
now_playing_suffix = "  $/b$8"
current_item_prefix = "$b$7$/b$3 "
current_item_suffix = "  $8"
song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}"
song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8"
song_status_format = "$b$2󰣐 $7 {$b$6$8 %t $6} $7 $8"

[header]
header_visibility                           = no
header_window_color                         = default
playlist_shorten_total_times                = yes
state_line_color                            = black
volume_color                                = default

[statusbar]
progressbar_color                           = "black"
progressbar_elapsed_color                   = "magenta"
progressbar_look                            = "▪▪▪"
#song_status_format                          = "{$b$3%t$/b $8by $b$4%a$8$/b}|{%f}"
statusbar_color                             = default
statusbar_visibility                        = yes
display_bitrate                             = no
display_remaining_time                      = no

[global]
allow_for_physical_item_deletion            = yes
autocenter_mode                             = yes
centered_cursor                             = yes
color1                                      = white
color2                                      = red
colors_enabled                              = yes
enable_window_title                         = yes
external_editor                             = vim
ignore_leading_the                          = yes
main_window_color                           = white
message_delay_time                          = 1
song_window_title_format                    = "mpd » {%a - }{%t}|{%f}"
titles_visibility                           = yes
user_interface                              = "classic"

[notification]
execute_on_song_change                      = ~/.config/ncmpcpp/notification

[lyrics]
lyrics_directory                            = ~/Music/.lyrics
follow_now_playing_lyrics                   = no
fetch_lyrics_for_current_song_in_background = no
store_lyrics_in_song_dir                    = yes
generate_win32_compatible_filenames         = yes


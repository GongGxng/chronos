extends Control

@onready var button_hover: AudioStreamPlayer2D = $button_hover
@onready var menu = $Menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio

func _ready():
	menu.show()
	options.hide()
	video.hide()
	audio.hide()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/upgrade_menu.tscn")
	SaveDb.load_game()
	
func _on_options_pressed(): 
	show_and_hide(options, menu)

func show_and_hide(first: Control, second: Control):
	first.show()
	second.hide()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_video_pressed() -> void:
	show_and_hide(video, options)

func _on_audio_pressed() -> void:
	show_and_hide(audio, options)

func _on_back_from_options_pressed() -> void:
	show_and_hide(menu, options)

func _on_full_screen_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)

func _on_v_sync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_back_from_video_pressed() -> void:
	show_and_hide(options, video)


func _on_master_value_changed(value: float) -> void:
	volume(0, value)
	
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_music_value_changed(value: float) -> void:
	volume(1, value)


func _on_sound_fx_value_changed(value: float) -> void:
	volume(2, value)


func _on_back_from_audio_pressed() -> void:
	show_and_hide(options, audio)

func _on_start_mouse_entered() -> void:
	button_hover.play()

func _on_options_mouse_entered() -> void:
	button_hover.play()

func _on_exit_mouse_entered() -> void:
	button_hover.play()

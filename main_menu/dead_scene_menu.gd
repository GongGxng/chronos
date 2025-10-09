extends Control
@onready var times_num_dp: Label = $HBoxContainer/VBoxContainer2/times_num
@onready var coins_num_dp: Label = $HBoxContainer/VBoxContainer2/coins_num

func _ready() -> void:
	get_tree().paused = false

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	SaveDb.save_game()
	print("restart")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu/upgrade_menu.tscn")
	SaveDb.save_game()
	print("back to menu")

func _on_character_time_up(times_num:Variant, coins_num:Variant) -> void:
	times_num_dp.text = str(times_num)
	coins_num_dp.text = str(coins_num)

extends Control

@onready var label: Label = $Label

var start_game = "res://start_game.tscn"
var main_menu = "res://main_menu/main_menu.tscn"

func _ready() -> void:
	label.text = str(SaveDb.coins)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(main_menu)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(start_game)

func _on_save_pressed() -> void:
	SaveDb.save_game()
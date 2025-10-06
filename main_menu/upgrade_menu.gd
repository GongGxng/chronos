extends Control

@onready var label: Label = $Label

var start_game = "res://start_game.tscn"
var main_menu = "res://main_menu/main_menu.tscn"
var name_type = ""
var description = ""
var cost = 0

func _process(_delta: float) -> void:
	label.text = str(SaveDb.coins)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(main_menu)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(start_game)

func _on_up_button_mouse_entered() -> void:
	var mouse_position = get_global_mouse_position()
	var popup_position = Rect2(mouse_position.x + 10, mouse_position.y + 10, 0, 0)
	Descrition.itempop_up(popup_position, name_type, description, cost)

func _on_up_button_mouse_exited() -> void:
	Descrition.hideitempop_up()

func _on_confirm_button_pressed() -> void:
	for i in SaveDb.upgrades.keys():
		SaveDb.upgrades[i] = 0
		SaveDb.coins += SaveDb.coins_spent
		SaveDb.coins_spent = 0
	SaveDb.save_game()
	get_tree().reload_current_scene()

func _on_up_button_upgrade_hovered(name_type:Variant, description:Variant, cost:Variant) -> void:
	self.name_type = name_type
	self.description = description
	self.cost = cost
extends Control
@onready var popup_panel: PopupPanel = $PopupPanel
@onready var name_upgrade: Label = %Name_upgrade
@onready var info_of_upgrade: Label = %Info_of_upgrade

func itempop_up(slot: Rect2i, name_type: String, description: String):
	set_value(name_type, description)
	popup_panel.position = Vector2(slot.position.x, slot.position.y)
	popup_panel.popup()

func hideitempop_up():
	popup_panel.hide()

func set_value(name_type: String, description: String):
	name_upgrade.text = name_type
	info_of_upgrade.text = description

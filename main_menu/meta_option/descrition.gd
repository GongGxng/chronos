extends Control
@onready var popup_panel: PopupPanel = $PopupPanel
@onready var name_upgrade: Label = %Name_upgrade
@onready var info_of_upgrade: Label = %Info_of_upgrade
@onready var info_of_upgrade_2: Label = %Info_of_upgrade2

func itempop_up(slot: Rect2i, name_type: String, description: String, cost: int):
	set_value(name_type, description, cost)
	popup_panel.position = Vector2(slot.position.x, slot.position.y)
	popup_panel.popup()

func hideitempop_up():
	popup_panel.hide()

func set_value(name_type: String, description: String, cost: int):
	name_upgrade.text = name_type
	info_of_upgrade.text = description
	info_of_upgrade_2.text = "Cost: " + str(cost) + " Coins"
extends ColorRect

@export var upgrade_option: Resource
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label
@onready var texture_button: TextureButton = $TextureButton

"""
	name = upgrade_option.name
	description = upgrade_option.description
	icon = upgrade_option.icon
	cost = upgrade_option.cost
	level = upgrade_option.level
	max_level = upgrade_option.max_level
	upgrade.texture_normal = upgrade_option.texture_normal
"""
@onready var name_type = upgrade_option.name
@onready var currentlv : int = SaveDb.upgrades[name_type]
@onready var maxlv : int = upgrade_option.max_level
@onready var icon = upgrade_option.icon
@onready var cost : int = upgrade_option.cost

func _ready():
	update()

func update():
	progress_bar.max_value = maxlv
	progress_bar.value = currentlv
	label.text = str(currentlv) + "/" + str(maxlv)
	texture_button.texture_normal = icon

func save_stats():
	if upgrade_option.name == "grab_area":
		SaveDb.upgrades["grab_area_lv"] = currentlv

#damage_lv
func _on_confirm_button_pressed() -> void:
	for i in SaveDb.upgrades.keys():
		if i == name_type:
			if SaveDb.upgrades[name_type] < maxlv:
				SaveDb.upgrades[name_type] += currentlv
				print("level ",name_type,SaveDb.upgrades[name_type])
	SaveDb.save_game()


func _on_texture_button_pressed() -> void:
	if currentlv < maxlv:
		if SaveDb.coins >= cost:
			SaveDb.coins -= cost
			currentlv += 1
			update()
	print(SaveDb.coins)

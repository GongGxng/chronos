extends PanelContainer

@export var upgrade_option: Resource
@onready var texture_button: TextureButton = %icon_texture
@onready var label: Label = %lbl_num
@onready var progress_bar: ProgressBar = %level_bar

@onready var name_type = upgrade_option.upgrade_type()
@onready var currentlv : int = SaveDb.upgrades[name_type]
@onready var description = upgrade_option.description
@onready var maxlv : int = upgrade_option.max_level
@onready var icon = upgrade_option.icon
@onready var icon_hover = upgrade_option.icon_hover
@onready var cost : int = upgrade_option.cost
@onready var name_display = upgrade_option.name_dp

signal upgrade_hovered(name_type, description)

func _ready():
	"""if upgrade_option == null:
		pass
	for i in SaveDb.upgrades.keys():
		print("SaveDb_check",SaveDb.upgrades[i])"""
	upgrade_option.upgrade_type()
	update()
	emit_signal("upgrade_hovered", name_type, description)
	return cost

func update():
	progress_bar.max_value = maxlv
	progress_bar.value = currentlv
	label.text = str(currentlv) + "/" + str(maxlv)
	texture_button.texture_normal = icon
	texture_button.texture_hover = icon_hover

func _on_texture_button_pressed() -> void:
	if currentlv < maxlv:
		if SaveDb.coins >= cost:
			SaveDb.coins -= cost
			currentlv += 1
			SaveDb.upgrades[name_type] = currentlv
			SaveDb.coins_spent += cost
			SaveDb.save_game()
			update()

func _on_mouse_entered() -> void:
	icon_hover
	emit_signal("upgrade_hovered", name_display, description)

func _on_mouse_exited() -> void:
	emit_signal("upgrade_hovered", "", "")

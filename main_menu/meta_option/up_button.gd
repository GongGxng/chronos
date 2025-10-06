extends PanelContainer

@export var upgrade_option: Resource
@onready var texture_button: TextureButton = %icon_texture
@onready var label: Label = %lbl_num
@onready var progress_bar: ProgressBar = %level_bar

@onready var name_type = upgrade_option.upgrade_type()
#@onready var currentlv : int = SaveDb.upgrades[name_type]
@onready var currentlv : int = _safe_get_level(name_type)
@onready var description = upgrade_option.description
@onready var maxlv : int = upgrade_option.max_level
@onready var icon = upgrade_option.icon
@onready var icon_hover = upgrade_option.icon_hover
@onready var cost : int = upgrade_option.cost
@onready var name_display = upgrade_option.name_dp

signal upgrade_hovered(name_type, description, cost)

func _safe_get_level(key: String) -> int:
	if typeof(SaveDb.upgrades) != TYPE_DICTIONARY:
		push_error("SaveDb.upgrades not dictionary")
		return 0
	if not SaveDb.upgrades.has(key):
		SaveDb.upgrades[key] = 0
		return 0
	return SaveDb.upgrades.get(key, 0)


func _ready():
	upgrade_option.upgrade_type()
	update()
	emit_signal("upgrade_hovered", name_type, description, cost)

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
	emit_signal("upgrade_hovered", name_display, description, cost)

func _on_mouse_exited() -> void:
	emit_signal("upgrade_hovered", "", "", "")

extends Node2D

var coins = 0
var upgrades = {
	"grab_area_lv": 0,
	"damage_lv": 0,
	"attack_spd_lv": 0,
	"atditionnal_attack_lv": 0,
	"attack_size_lv": 0,
}

func _process(_delta: float) -> void:
    #print(coins)
    pass

const PATH = "user://player_data.json"

func save_game():
    var data = {
        "coins": coins,
        "upgrades": upgrades
    }
    var file = FileAccess.open(PATH, FileAccess.WRITE)
    file.store_string(JSON.stringify(data))
    file.close()
    print("Game saved.")

func load_game():
    if not FileAccess.file_exists(PATH):
        save_game()
        return
    var file = FileAccess.open(PATH, FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text())
    file.close()
    if typeof(data) == TYPE_DICTIONARY:
        coins = data.get("coins", 0)
        upgrades = data.get("upgrades", upgrades)

"""func _ready() -> void:
	var player_data = load_player_data()
	coins = player_data.coins
	upgrades = player_data.upgrades

func load_player_data() -> Dictionary:
	# Placeholder for loading player data from a save file
	return {
		"coins": 0,
		"upgrades": {}
	}

func save_player_data() -> void:
	# Placeholder for saving player data to a save file
	pass

# =============================
# END OF RUN (AFTER GAME OVER)
# =============================
func on_run_finished(collected_coins: int) -> void:
	coins += collected_coins
	save_player_data()

# =============================
# OPEN META MENU
# =============================
func open_meta_menu() -> void:
	$CoinsLabel.text = str(coins)
	$UpgradesList.clear()
	for upgrade in upgrades.keys():
		$UpgradesList.add_item(upgrade + " (Level: " + str(upgrades[upgrade]) + ")")
	$ConfirmButton.disabled = true

# =============================
# SELECT UPGRADE
# =============================
var selected_upgrade = null

func on_upgrade_selected(upgrade_type: String) -> void:
	var cost = get_upgrade_cost(upgrade_type, upgrades.get(upgrade_type, 0))
	if coins >= cost:
		preview_upgrade_effect(upgrade_type)
		$ConfirmButton.disabled = false
		selected_upgrade = upgrade_type
	else:
		$MessageLabel.text = "Not enough coins"

func get_upgrade_cost(_upgrade_type: String, current_level: int) -> int:
	# Placeholder for calculating upgrade cost
	return (current_level + 1) * 10

func preview_upgrade_effect(_upgrade_type: String) -> void:
	# Placeholder for previewing the upgrade effect
	pass

# =============================
# CONFIRM UPGRADE
# =============================
func on_confirm_pressed() -> void:
	if selected_upgrade == null:
		return

	var cost = get_upgrade_cost(selected_upgrade, upgrades.get(selected_upgrade, 0))
	coins -= cost
	upgrades[selected_upgrade] = upgrades.get(selected_upgrade, 0) + 1
	save_player_data()

	$MessageLabel.text = "Upgrade Successful"
	$ConfirmButton.disabled = true

# =============================
# START NEW RUN
# =============================
func start_new_run() -> void:
	var player_data = load_player_data()
	coins = player_data.coins
	upgrades = player_data.upgrades
	apply_upgrades_to_gameplay()

func apply_upgrades_to_gameplay() -> void:
	# Placeholder for applying upgrades to gameplay
	pass"""

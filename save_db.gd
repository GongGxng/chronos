extends Node2D

var coins = 0
var upgrades = {
	"grab_area_lv": 0,
	"damage_lv": 0,
	"attack_spd_lv": 0,
	"atditionnal_attack_lv": 0,
	"attack_size_lv": 0,
}
var coins_spent = 0
var coins_collected = 0
var time_survived = 0

const PATH = "user://player_data.json"

func save_game():
	var data = {
		"coins": coins,
		"upgrades": upgrades,
		"coins_spent": coins_spent,
		"time_survived": time_survived
	}
	var	file = FileAccess.open(PATH, FileAccess.WRITE)
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
		coins_spent = data.get("coins_spent", 0)
		time_survived = data.get("time_survived", 0)


func highest_score(new_time: int):
	if new_time > time_survived:
		time_survived = new_time
		save_game()
		print("New highest score saved: ", time_survived)
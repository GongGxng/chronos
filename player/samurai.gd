extends "res://player/character.gd"

@export var speed_bonus: int = 20
@export var time_penalty: int = 10

func _ready():
	movement_speed += speed_bonus
	current_time = max(1, current_time - time_penalty)
	upgrade_character("katana1")
	super._ready()
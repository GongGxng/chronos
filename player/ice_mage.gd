extends "res://player/character.gd"

@export var speed_bonus: int = 5
@export var time_penalty: int = 10

func _ready():
	movement_speed += speed_bonus
	upgrade_character("ice_cube1")
	super._ready()
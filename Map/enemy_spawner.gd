extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var proc_gen_world = get_node("%proc_gen_world")

@export var spawn: Array[Spawn_info] = []
@export var time = 0
@export var hp_growth_rate: float = 1.3
@onready var base_hp: int = 0
@onready var base_resistance: int = 0

var map_numselection = 0

func _on_proc_gen_world_map_number(map:int) -> void:
	map_numselection = map

var enemy_cap = 200
var enemy_to_spawn = []

func _ready() -> void:
	_find_player_deferred()

func _find_player_deferred() -> void:
	call_deferred("_find_player")

func _find_player() -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")


func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawn
	var get_children = get_children()
	for i in enemy_spawns:
		if i.map_can_spawn == map_numselection:
			if time >= i.time_start and time <= i.time_end:
				if i.spawn_delay_counter < i.enemy_spawn_delay:
					i.spawn_delay_counter += 1
				else:
					i.spawn_delay_counter = 0
					var new_enemy = i.enemy
					var counter = 0
					while counter < i.enemy_num:
						if get_children.size() <= enemy_cap:
							var enemy_spawn = new_enemy.instantiate()
							enemy_spawn.global_position = get_random_position()
							base_hp = enemy_spawn.hp
							base_resistance = enemy_spawn.resistance
							enemy_spawn.resistance = get_scaled_resistance()
							enemy_spawn.hp = get_scaled_hp()
							add_child(enemy_spawn)
						else :
							enemy_to_spawn.append(new_enemy)
						counter += 1
	if get_children.size() <= enemy_cap and enemy_to_spawn.size() > 0:
		var spawn_number = clamp(enemy_to_spawn.size(),1,50) - 1
		var counter = 0
		while counter < spawn_number:
			var enemy_spawn = enemy_to_spawn[0].instantiate()
			enemy_spawn.global_position = get_random_position()
			base_hp = enemy_spawn.hp
			base_resistance = enemy_spawn.resistance
			enemy_spawn.resistance = get_scaled_resistance()
			enemy_spawn.hp = get_scaled_hp()
			add_child(enemy_spawn)
			enemy_to_spawn.remove_at(0)
			counter += 1

func get_scaled_hp() -> int:
	var scaled_hp = base_hp * pow(hp_growth_rate, time / 60)
	return int(scaled_hp)

func get_scaled_resistance() -> int:
	var scaled_resistance = base_resistance * pow(hp_growth_rate, time / 60)
	return int(scaled_resistance)

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_side = ["up","down","right","left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y,spawn_pos2.y)
	return Vector2(x_spawn,y_spawn)

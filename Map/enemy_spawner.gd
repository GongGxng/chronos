extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var proc_gen_world = get_node("%proc_gen_world")

@export var spawn: Array[Spawn_info] = []
@export var time = 0
@export var hp_growth_rate: float = 10
@export var base_hp: int = 1.3

var map_numselection = 0

func _on_proc_gen_world_map_number(map:int) -> void:
	print("received map: ", map)
	map_numselection = map

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawn
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
						var enemy_spawn = new_enemy.instantiate()
						enemy_spawn.global_position = get_random_position()
						enemy_spawn.hp = get_scaled_hp()
						add_child(enemy_spawn)
						counter += 1
						print(enemy_spawn.hp)

func get_scaled_hp() -> int:
	var scaled_hp = base_hp * pow(hp_growth_rate, time / 30)
	return int(scaled_hp)

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
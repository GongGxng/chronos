extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_prop_text : NoiseTexture2D

var noise : Noise
var prop_noise : Noise

@onready var ground_1_tile_layer: TileMapLayer = $TileMap2/ground1
@onready var ground_2_tile_layer: TileMapLayer = $TileMap2/ground2
@onready var prop_tile_layer: TileMapLayer = $TileMap2/prop

var width = 250
var height = 250

var source_id = 0

# terrain_int
var dirt_tile_arr = []
var terrain_dirt_int = 0

var rock_tile_arr = []
var terrain_lava_int = 1

var brick_tile_arr =[]
var terrain_brick_int = 2

# forest tiles
var ground_arr1 = [Vector2i(0,0),Vector2i(1,0),Vector2i(2,0),Vector2i(0,1),Vector2i(1,1),Vector2i(2,1),Vector2i(0,2),Vector2i(1,2),Vector2i(2,2)]
var grass_arr2 = [Vector2i(3,0),Vector2i(4,0),Vector2i(5,0),Vector2i(3,1),Vector2i(4,1),Vector2i(5,1),Vector2i(3,2),Vector2i(4,2),Vector2i(5,2)]
var prop_arr_nature = [Vector2i(6,1),Vector2i(8,0)]
var prop_arr_dirt = [Vector2i(7,0),Vector2i(6,0)]

# lava tiles
var ground_lava_arr = [Vector2i(0,3),Vector2i(1,3),Vector2i(2,3),Vector2i(0,4),Vector2i(1,4),Vector2i(2,4),Vector2i(0,5),Vector2i(1,5),Vector2i(2,5)]
var prop_lava_arr = [Vector2i(0,6),Vector2i(1,6),Vector2i(2,6)]

# brick tiles
var mos_brick_arr = [Vector2i(3,3),Vector2i(4,3),Vector2i(5,3),Vector2i(3,4),Vector2i(4,4),Vector2i(5,4),Vector2i(3,5),Vector2i(4,5),Vector2i(5,5)]
var prop_brick_arr = [Vector2i(6,3),Vector2i(6,4),Vector2i(6,5),Vector2i(7,4)]

# electic floor
var future_arr = [Vector2i(3,9),Vector2i(4,9),Vector2i(5,9),Vector2i(3,10),Vector2i(4,10),Vector2i(5,10),Vector2i(3,11),Vector2i(4,11),Vector2i(5,11)]
var future_prop_arr = [Vector2i(6,9),Vector2i(6,11),Vector2i(6,11)]

var noise_val_array = []
var map_num = [0,1,2]
var map : int
var rng = RandomNumberGenerator.new()
var rng_seed = int(rng.randf_range(0, 50))

signal map_number(map: int)

func _ready():
	noise = noise_height_text.noise
	prop_noise = noise_prop_text.noise
	generate_world()

func generate_world():
	noise.seed = rng_seed
	map = 1#map_num.pick_random()
	print("map_num : ",map)
	emit_signal("map_number", map)
	if map == 0:
		print("enter map 1")
		for x in range(-width/2, width/2):
			for y in range(-height/2, height/2):
				var noise_value :float = noise.get_noise_2d(x,y)
				var prop_noise_value :float = prop_noise.get_noise_2d(x,y)

				if noise_value >= 0.2:
					rock_tile_arr.append(Vector2i(x,y))
					if prop_noise_value >= 0.82:
						prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_lava_arr.pick_random())
				elif noise_value <= 0.2:
					if prop_noise_value >= 0.1 and prop_noise_value <= 0.3:
						ground_1_tile_layer.set_cell( Vector2i(x,y), source_id, ground_lava_arr.pick_random())
					else :
						rock_tile_arr.append(Vector2i(x,y))
					if prop_noise_value >= 0.82:
						prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_lava_arr.pick_random())

		ground_2_tile_layer.set_cells_terrain_connect(rock_tile_arr, terrain_lava_int, 0)

	elif map == 1:
		print("enter map 2")
		for x in range(-width/2, width/2):
			for y in range(-height/2, height/2):
				var noise_value :float = noise.get_noise_2d(x,y)
				var prop_noise_value :float = prop_noise.get_noise_2d(x,y)

				ground_1_tile_layer.set_cell( Vector2i(x,y), source_id, grass_arr2.pick_random())
				if noise_value >= 0.2:
					dirt_tile_arr.append(Vector2i(x,y))
					if prop_noise_value >= 0.82:
						prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_arr_dirt.pick_random())
				elif noise_value <= 0.0 and prop_noise_value >= 0.82:
					prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_arr_nature.pick_random())

		ground_2_tile_layer.set_cells_terrain_connect(dirt_tile_arr, terrain_dirt_int, 0)

	elif map == 2:
		print("enter map 3")
		for x in range(-width/2, width/2):
			for y in range(-height/2, height/2):
				var noise_value :float = noise.get_noise_2d(x,y)
				var prop_noise_value :float = prop_noise.get_noise_2d(x,y)
				ground_1_tile_layer.set_cell( Vector2i(x,y), source_id, mos_brick_arr.pick_random())
				if noise_value >= 0.2:
					if prop_noise_value >= 0.82:
						prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_brick_arr.pick_random())
				elif noise_value <= 0.2:
					if prop_noise_value >= 0.35:
						brick_tile_arr.append(Vector2i(x,y))
					if prop_noise_value >= 0.82:
						prop_tile_layer.set_cell(Vector2i(x,y), source_id, prop_brick_arr.pick_random())
		ground_2_tile_layer.set_cells_terrain_connect(brick_tile_arr, terrain_brick_int, 0)
	elif map == 3:
		print("enter map 4")
		for x in range(-width/2, width/2):
			for y in range(-height/2, height/2):
				var noise_value :float = noise.get_noise_2d(x,y)
				var prop_noise_value :float = prop_noise.get_noise_2d(x,y)
				noise_val_array.append(noise_value)
				ground_2_tile_layer.set_cell( Vector2i(x,y), source_id, future_arr.pick_random())

	else :
		print("enter map None")
	
	"""print("low ",noise_val_array.min())
	print("high ",noise_val_array.max())"""

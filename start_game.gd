extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var dead_scene_menu_2 = $CanvasLayer/dead_scene_menu2
@onready var character = SaveDb.character_selected_part
@onready var y_sort: Node2D = $y_sort
@onready var skill_info_2: Label = $skill_info2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#music
@onready var music_1: AudioStreamPlayer2D = $music1
@onready var music_2: AudioStreamPlayer2D = $music2
@onready var music_3: AudioStreamPlayer2D = $music3
var picked_music = pick_random_music()

func pick_random_music() -> AudioStreamPlayer2D:
	var music_options = [music_1, music_2, music_3]
	var random_index = randi() % music_options.size()
	return music_options[random_index]
	
func _ready() -> void:
	pick_random_music().play()
	character_load()

func character_load() -> void:
	print(character)
	var character_scene = load(character)
	var character_instance = character_scene.instantiate()
	y_sort.add_child(character_instance)
	character_instance.position = Vector2(0, 0)
	character_instance.game_over.connect(_on_character_game_over)
	character_instance.time_up.connect(dead_scene_menu_2._on_character_time_up)
	if not character_instance.is_in_group("player"):
		character_instance.add_to_group("player")

func _process(_delta: float) -> void:
	change_canvas_layer()

func change_canvas_layer() -> void:
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		canvas_layer.layer = 2
	else:
		canvas_layer.layer = 0

func _on_character_game_over() -> void:
	canvas_layer.layer = 2
	dead_scene_menu_2.visible = true

func _on_skill_info_timeout() -> void:
	animation_player.play("fade")

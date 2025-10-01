extends Area2D

@export var experience = 1

var spr_exp = preload("res://objects/exp.PNG")

var target = null
var speed = -0.5

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D
@onready var animetion = $AnimationPlayer

func _ready():
    animetion.play("exp_spin")

func _process(delta):
    if target != null:
        global_position = global_position.move_toward(target.global_position, speed)
        speed += delta * 2
        
func collect_exp():
    sound.play()
    collision.call_deferred("set", "disabled", true)
    sprite.visible = false
    return experience

func _on_audio_stream_player_2d_finished():
    queue_free()



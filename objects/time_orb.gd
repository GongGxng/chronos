extends Area2D

@export var time_orb_amount = 1

var spr_time_orb = preload("res://objects/timegem.PNG")

var target = null
var speed = -0.5

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D
@onready var animetion = $AnimationPlayer

func _ready():
    animetion.play("time_spin")

func _process(delta):
    if target != null:
        global_position = global_position.move_toward(target.global_position, speed)
        speed += delta * 2
        
func collect_time():
    if target != null and target.has_method("_on_time_orb_collected"):
        target._on_time_orb_collected(time_orb_amount)
    sound.play()
    collision.call_deferred("set", "disabled", true)
    sprite.visible = false
    return time_orb_amount

func _on_audio_stream_player_2d_finished():
    queue_free()

extends Area2D

@export var coins = 1

var spr_coins = preload("res://objects/coins.png")
var spr_coins1 = preload("res://objects/coins1.png")

var target = null
var speed = -0.5

@onready var sprite = $Sprite2D
@onready var collision = $AudioStreamPlayer2D
@onready var sound = $AudioStreamPlayer2D
@onready var animetion = $AnimationPlayer

#@onready var upgrade_menu = get_node("res://main_menu/upgrade_menu.tscn")

func _ready():
    animetion.play("coins_spin")
    if coins >= 1:
        sprite.texture = spr_coins1
    elif coins >= 5:
        sprite.texture = spr_coins

func _process(delta):
    if target != null:
        global_position = global_position.move_toward(target.global_position, speed)
        speed += delta * 2
        
func collect_coin():
    sound.play()
    collision.call_deferred("set", "disabled", true)
    sprite.visible = false

    # Update coins in Meta Progression system
    """if upgrade_menu:
        upgrade_menu.add_coins(coins)"""

    return coins

func _on_audio_stream_player_2d_finished():
    queue_free()

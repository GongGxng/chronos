extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var Sprite = $Sprite2
@onready var animation = $AnimationPlayer
@onready var hitBox = $hitbox
@onready var fire_ball_time: Timer = $fire_ball_time

@export var movement_speed = 200
@export var base_hp = 1
@export var hp = 1
@export var knockback_recovery = 3.5
@export var experience = 1
@export var time_orb_amount = 10
@export var coins_amount = 5
@export var resistance = 10
@export var enemy_damage = 1
@export var can_drop_time_orb = true

var knockback = Vector2.ZERO
var exp_gem = preload("res://objects/Expgem.tscn")
var time_orb_scene = preload("res://objects/time_orb.tscn")
var coins_scene = preload("res://objects/coins.tscn")

@onready var direction = global_position.direction_to(player.global_position)

signal remove_from_array(object)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	velocity = direction * movement_speed
	velocity += (knockback / resistance)
	move_and_slide()

	if direction.x > 0.1:
		Sprite.flip_h = true
	elif direction.x < -0.1:
		Sprite.flip_h = false

func _ready():
	hitBox.damage = enemy_damage
	animation.play("walk")
	fire_ball_time.start()

func random_position():
	var random_offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
	return global_position + random_offset

func death():
	emit_signal("remove_from_array", self)
	queue_free()

func _on_hurtbox_hurt(damage, angle, knockback_amount) -> void:
	hp -= damage
	death()

func _on_fire_ball_time_timeout() -> void:
	queue_free()
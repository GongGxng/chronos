extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var Sprite = $Sprite2
@onready var animation = $AnimationPlayer
@onready var hitBox = $hitbox

@export var movement_speed = 25
@export var hp = 10
@export var knockback_recovery = 3.5
@export var experience = 1
@export var time_orb_amount = 10
@export var resistance = 10
@export var enemy_damage = 1

var knockback = Vector2.ZERO
var exp_gem = preload("res://objects/Expgem.tscn")
var time_orb_scene = preload("res://objects/time_orb.tscn")

signal remove_from_array(object)

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += (knockback / resistance)
	move_and_slide()
	move_and_collide(velocity * _delta)

	if direction.x > 0.1:
		Sprite.flip_h = true
	elif direction.x < -0.1:
		Sprite.flip_h = false
	
func _ready():
	hitBox.damage = enemy_damage
	animation.play("orcwalk")

func death():
	emit_signal("remove_from_array", self)
	var new_time_orb = time_orb_scene.instantiate()
	new_time_orb.global_position = global_position
	new_time_orb.time_orb_amount = time_orb_amount
	loot_base.call_deferred("add_child", new_time_orb)

	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	queue_free()

func _on_hurtbox_hurt(damage, angle, knockback_amount) -> void:
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()

extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var Sprite = $Sprite2D2
@onready var animation = $AnimationPlayer
@onready var hitBox = $hitbox

@export var movement_speed = 25
@export var hp = 10
@export var knockback_recovery = 3.5
@export var experience = 1
@export var damage = 1

var type : enemy_rs:
	set(value):
		type = value
		
var collide = Vector2.ZERO
var knockback = Vector2.ZERO
var exp_gem = preload("res://objects/Expgem.tscn")

signal remove_from_array(object)


func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback


	move_and_slide()
	move_and_collide(velocity * _delta)

	if direction.x > 0.1:
		Sprite.flip_h = true
	elif direction.x < -0.1:
		Sprite.flip_h = false
	
func _ready():
	animation.play("test")
	hitBox.damage = damage

func death():
	emit_signal("remove_from_array", self)
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

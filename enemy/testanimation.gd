extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var movement_speed = 50
@onready var player = get_tree().get_first_node_in_group("player")
@onready var Sprite = $Sprite2D
@export var hp = 10

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()

	if direction.x > 0.1:
		Sprite.flip_h = true
	elif direction.x < -0.1:
		Sprite.flip_h = false

func _ready():
	animation.play("testty")

func _on_hurtbox_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
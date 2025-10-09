extends Area2D

var level = 1
var hp = 1
var speed = 150
var damage = 5
var knockback_amount = 80
var attack_size = 1

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var slash: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var ghost_timer = $ghost

@export var ghost_node : PackedScene

signal remove_from_array(object)

func _ready():
	slash.play()
	dash()
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 2
			speed = 400
			damage = 5
			knockback_amount = 80
			attack_size = 1 * (1 + (player.spell_size))
		2:
			hp = 2
			speed = 500
			damage = 5
			knockback_amount = 120
			attack_size = 1.2 * (1 + (player.spell_size))
		3:
			hp = 4
			speed = 600
			damage = 8
			knockback_amount = 140
			attack_size = 1.4 * (1 + (player.spell_size))
		4:
			hp = 4
			speed = 700
			damage = 10
			knockback_amount = 140
			attack_size = 1.4 * (1 + (player.spell_size))
		5:
			hp = 4
			speed = 800
			damage = 10
			knockback_amount = 145
			attack_size = 1.8 * (1 + (player.spell_size))
		6:
			hp = 6
			speed = 900
			damage = 15
			knockback_amount = 150
			attack_size = 2 * (1 + (player.spell_size))
		7:
			hp = 6
			speed = 1000
			damage = 20
			knockback_amount = 150
			attack_size = 2.2 * (1 + (player.spell_size))

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * attack_size, 0.1).set_trans(tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
var velocity = Vector2.ZERO

func _physics_process(delta):
	position += angle * speed * delta
	velocity = angle * speed

func enemy_hit(amount = 1):
	hp -= amount
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, $Sprite2D.scale)
	get_tree().current_scene.add_child(ghost)

func dash():
	ghost_timer.start()

	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + velocity * 1.5, 0.45)

	await tween.finished
	ghost_timer.stop()

func _on_ghost_timeout() -> void:
	add_ghost()

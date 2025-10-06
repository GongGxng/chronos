extends Area2D

var level = 1
var hp = 1
var speed = 150
var damage = 5
var knockback_amount = 80
var attack_size = 1

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

func _ready():
	animation_player.play("bullet")
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 2
			speed = 150
			damage = 5
			knockback_amount = 80
			attack_size = 1 * (1 + (player.spell_size))
		2:
			hp = 2
			speed = 170
			damage = 5
			knockback_amount = 120
			attack_size = 1.2 * (1 + (player.spell_size))
		3:
			hp = 4
			speed = 170
			damage = 8
			knockback_amount = 140
			attack_size = 1.4 * (1 + (player.spell_size))
		4:
			hp = 4
			speed = 200
			damage = 10
			knockback_amount = 140
			attack_size = 1.4 * (1 + (player.spell_size))
		5:
			hp = 4
			speed = 250
			damage = 10
			knockback_amount = 145
			attack_size = 1.8 * (1 + (player.spell_size))
		6:
			hp = 6
			speed = 300
			damage = 15
			knockback_amount = 150
			attack_size = 2 * (1 + (player.spell_size))
		7:
			hp = 6
			speed = 350
			damage = 20
			knockback_amount = 150
			attack_size = 2.2 * (1 + (player.spell_size))

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * attack_size, 0.1).set_trans(tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	position += angle*speed*delta

func enemy_hit(amount = 1):
	hp -= amount
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()

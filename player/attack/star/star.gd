extends Area2D

var level = 1
var hp = 9999
var damage = 10
var speed = 200
var knockback_amount = 100
var paths = 1
var attack_size = 1
var attack_speed = 4
@export var speedSet = 200
@export var damageSet = 10

var target = Vector2.ZERO
var target_array = []

var angle = Vector2.ZERO
var reset_pos = Vector2.ZERO

@onready var spr_star = preload("res://player/attack/star/star2idle.png")
var spr_star_attack = preload("res://player/attack/star/staratt.png")

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var attackTimer = get_node("%attacktimer")
@onready var changedirectionTimer = get_node("%changedirection")
@onready var resetPostimer = get_node("%resetpostimer")
@onready var snd__attack = $snd_attack

signal remove_from_array(object)

func _ready() -> void:
	update_star()
	_on_resetpostimer_timeout()

func update_star():
	level = player.star_level
	match level:
		1:
			hp = 9999
			speed = speedSet
			damage = damageSet
			knockback_amount = 100
			paths = 1
			attack_size = 1 * (1 + (player.spell_size))
			attack_speed = 5 * (1 - player.spell_cooldown)
		2:
			hp = 9999
			speed = speedSet
			damage = damageSet
			knockback_amount = 100
			paths = 2
			attack_size = 1 * (1 + (player.spell_size))
			attack_speed = 5 * (1 - player.spell_cooldown)
		3:
			hp = 9999
			speed = speedSet
			damage = damageSet
			knockback_amount = 100
			paths = 3
			attack_size = 1 * (1 + (player.spell_size))
			attack_speed = 5 * (1 - player.spell_cooldown)
		4:
			hp = 9999
			speed = speedSet
			damage = damageSet + 5
			knockback_amount = 120
			paths = 4
			attack_size = 1 * (1 + (player.spell_size))
			attack_speed = 5 * (1 - player.spell_cooldown)
			
	damage = damageSet + player.damage_inc
	scale = Vector2(1, 1) * attack_size
	attackTimer.wait_time = attack_speed

func _physics_process(delta):
	if target_array.size() > 0:
		position += angle * speed * delta
	else:
		var player_angle = global_position.direction_to(reset_pos)
		var distance_dif = global_position - player.global_position
		
		var return_speed = 20
		if abs(distance_dif.x) > 5 or abs(distance_dif.y) > 5:
			return_speed = 80
		position += player_angle * return_speed * delta
		rotation = global_position.direction_to(player.global_position).angle()

func add_paths() -> void:
	emit_signal("remove_from_array", self)
	target_array.clear()
	var counter = 0
	while counter < paths:
		var new_path = player.get_random_target()
		target_array.append(new_path)
		counter += 1
		enable_attack(true)
	target = target_array[0]
	process_path()

func process_path() -> void:
	angle = global_position.direction_to(target)
	changedirectionTimer.start()
	var tween = create_tween()
	var new_rotation_degrees = angle.angle() + deg_to_rad(90)
	tween.tween_property(self, "rotation", new_rotation_degrees, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.play()


func enable_attack(attack = true) -> void:
	if attack:
		collision.call_deferred("set","disabled", false)
		sprite.texture = spr_star_attack
	else:
		collision.call_deferred("set","disabled", true)
		sprite.texture = spr_star

func _on_attacktimer_timeout() -> void:
	add_paths()

func _on_changedirection_timeout() -> void:
	if target_array.size() > 0:
		target_array.remove_at(0)
		if target_array.size() > 0:
			target = target_array[0]
			process_path()
			emit_signal("remove_from_array", self)
		else:
			enable_attack(false)
	else :
		changedirectionTimer.stop()
		attackTimer.start()
		enable_attack(false)

func _on_resetpostimer_timeout() -> void:
	var choose_direction = randi() % 4
	reset_pos = player.global_position
	match choose_direction:
		0:
			reset_pos.x += 100
		1:
			reset_pos.x -= 100
		2:
			reset_pos.y += 100
		3:
			reset_pos.y -= 100

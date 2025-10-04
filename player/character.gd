extends CharacterBody2D

@export var movement_speed = 70
@export var hp = 600
@export var maxhp = 600
@export var Character_name = ""

@export var current_time = 100
var is_game_over = false 

@onready var Sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var timelabel = get_node("%Labeltime")
@onready var camera_2d: Camera2D = $Camera2D
#gui
@onready var level_panal = get_node("%levelup")
@onready var upgradeOptions = get_node("%upgrade_options")
@onready var snd_levelup = ("%sound_levelup")
@onready var itemoptions = preload("res://utility/itemoptions.tscn")
@onready var coins_display: Label = %coins_display

#slowmotion
@export var normal_time_scale: float = 1.0
@export var slowmo_time_scale: float = 0.2
var is_slowmo_active : bool = false

#level&experience
@onready var expbar = get_node("%expbar")
@onready var expbar_label = get_node("%lbl_level")
var experience = 0
var experience_level = 1
var collected_experience = 0

#attack
var ice_cube = preload("res://player/attack/ice_cube/ice_cube.tscn")
@onready var ice_cube_timer: Timer = $attack/ice_cubeTimer
@onready var ice_cube_attack_timer = $attack/ice_cubeTimer/ice_cubeAttackTimer
#star
var star = preload("res://player/attack/star/star.tscn")
@onready var starbase = get_node("%starbase")

#ice_cube
var ice_cube_ammo = 1
var ice_cube_base_ammo = 0
var ice_cube_attackspeed = 1
var ice_cube_level = 0

#star
var star_ammo = 0
var star_level = 0

#enemy ralated
var enemy_close = []

#upgrade
var collected_upgrade = []
var upgrade_options = []
var damage_inc = 0
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0
var coins_collect = 0

func _ready() -> void:
	upgrade_effect()
	upgrade_charecter("ice_cube4")
	upgrade_charecter("star4")
	attack()
	set_expbar(experience, calculate_experiencecap())

func activate_slowmo():
	is_slowmo_active = true
	Engine.time_scale = slowmo_time_scale

func deactivate_slowmo():
	is_slowmo_active = false
	Engine.time_scale = normal_time_scale

func _physics_process(_delta):
	up_date_coin_colleted()
	skill_active()
	movement()

func attack():
	if ice_cube_level > 0:
		ice_cube_timer.wait_time = ice_cube_attackspeed * (1.0 - spell_cooldown)
		if ice_cube_timer.is_stopped():
			ice_cube_timer.start()
	if star_level > 0:
		spawn_star()

func spawn_star():
	var get_star_total = starbase.get_child_count()
	var calc_spawn = (star_ammo + additional_attacks) - get_star_total
	while calc_spawn > 0:
		var star_spawn = star.instantiate()
		star_spawn.global_position = global_position
		starbase.add_child(star_spawn)
		calc_spawn -= 1
	#update star level and stats
	var get_star = starbase.get_children()
	for i in get_star:
		if  i.has_method("update_star"):
			i.update_star()

func movement() -> void:
	var x_mov = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_mov = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var mov = Vector2(x_mov, y_mov)	
	velocity = mov.normalized() * movement_speed
	move_and_slide()

	if mov != Vector2.ZERO:
		animation.play("walk")
	elif mov == Vector2.ZERO:
		animation.play("idle")

func update_time(delta: float) -> void:
	if is_game_over:
		return
	
	current_time -= delta
	
	var minute = floor(current_time) / 60
	var second = int(current_time) % 60
	timelabel.text = "%02d:%02d" % [minute, second]

	if current_time <= 1:
		trigger_game_over()
	
func trigger_game_over() -> void:
	is_game_over = true
	get_tree().paused = true
	#Engine.time_scale = slowmo_time_scale
	print("Game Over")

func _process(delta: float) -> void:
	if not is_game_over:
		update_time(delta)

	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x < 0 and Sprite.flip_h:
		Sprite.flip_h = false
	elif mouse_direction.x > 0 and not Sprite.flip_h:
		Sprite.flip_h = true

func _on_hurtbox_hurt(damage, _angle, _knockback) -> void:
	current_time -= clamp(damage-armor ,1 ,999)

func _on_ice_cube_timer_timeout() -> void:
	ice_cube_ammo += ice_cube_base_ammo + additional_attacks
	ice_cube_attack_timer.start()

func _on_ice_cube_attack_timer_timeout() -> void:
	if ice_cube_ammo > 0:
		var ice_cube_attack = ice_cube.instantiate()
		ice_cube_attack.position = position
		ice_cube_attack.target = get_random_target()
		ice_cube_attack.level = ice_cube_level
		add_child(ice_cube_attack)
		ice_cube_ammo -= 1
		if ice_cube_ammo > 0:
			ice_cube_attack_timer.start()
		else:
			ice_cube_attack_timer.stop()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemydetection_area_body_entered(body:Node2D) -> void:
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemydetection_area_body_exited(body:Node2D) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)

func _on_grabarea_area_entered(area:Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self

func _on_time_orb_collected(amount: int) -> void:
	current_time += amount
	print("Time orb collected! Added time: ", amount, " Current time: ", current_time)

func _on_collectarea_area_entered(area:Area2D) -> void:
	if area.is_in_group("loot"):
		if area.has_method("collect_exp"):
			var gem_exp = area.collect_exp()
			calculate_experience(gem_exp)
		elif area.has_method("collect_time"):
			var time_amount = area.collect_time()
			_on_time_orb_collected(time_amount)
		elif area.has_method("collect_coin"):
			var coin_amount = area.collect_coin()
			SaveDb.coins += coin_amount
			coins_collect += coin_amount
			"""var upgrade_menu = get_node("res://main_menu/upgrade_menu.tscn")
			if upgrade_menu:
				upgrade_menu.coins += coin_amount
				print("Coin collected! Added coins: ", coin_amount, " Total coins: ", upgrade_menu.coins)"""

func up_date_coin_colleted():
	coins_display.text = str("Coin : ",coins_collect)

func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required-experience
		experience_level += 1
		expbar_label.text = "Level %d" % experience_level 
		experience = 0
		exp_required = calculate_experiencecap()
		level_up()
	else:
		experience += collected_experience
		collected_experience = 0

	set_expbar(experience, exp_required)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = 2 + experience_level*5
	elif experience_level < 40:
		exp_cap = 95 + (experience_level-19)*8
	else:
		exp_cap = 255 + (experience_level-39)*12
		
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expbar.value = set_value
	expbar.max_value = set_max_value

func level_up():
	"snd_levelup.play()"

	expbar_label.text = "Level %d" % experience_level
	var tween = level_panal.create_tween()
	tween.tween_property(level_panal, "position", Vector2(220, 50), 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	level_panal.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemoptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	
	get_tree().paused = true

	"Engine.time_scale = slowmo_time_scale"

func upgrade_charecter(upgrade):
	match upgrade:
		"ice_cube1":
			ice_cube_level = 1
			ice_cube_base_ammo += 1
		"ice_cube2":
			ice_cube_level = 2
			ice_cube_base_ammo += 1
		"ice_cube3":
			ice_cube_level = 3
		"ice_cube4":
			ice_cube_level = 4
			ice_cube_base_ammo += 2
		"star1":
			star_level = 1
			star_ammo = 1
		"star2":
			star_level = 2
		"star3":
			star_level = 3
		"star4":
			star_level = 4
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 10
		"tome1","tome2","tome3","tome4":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cooldown += 0.05
		"ring1","ring2":
			additional_attacks += 1
		"food":
			pass
			hp += 20
			hp = clamp(hp,0,maxhp)

	attack()

	var options_children = upgradeOptions.get_children()
	for i in options_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrade.append(upgrade)
	level_panal.visible = false
	level_panal.position = Vector2(220, -200)
	get_tree().paused = false
	calculate_experience(0)
	
	print("upgraded with ", collected_upgrade)
	"Engine.time_scale = normal_time_scale"

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrade:
			pass
		elif i in upgrade_options:
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item":
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0:
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrade:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null

@onready var grabarea: Area2D = $grabarea

func upgrade_effect():
	for i in SaveDb.upgrades.keys():
		match i:
			"atditional_attack_lv":
				additional_attacks = SaveDb.upgrades[i]
			"attack_size_lv":
				spell_size = 0.10 * SaveDb.upgrades[i]
			"attack_spd_lv":
				spell_cooldown = 0.05 * SaveDb.upgrades[i]
			"damage_lv":
				damage_inc = SaveDb.upgrades[i]
			"grab_area_lv":
				grabarea.scale = Vector2(1, 1) * (1 + (0.2 * SaveDb.upgrades[i]))

func skill_active():
	if Input.is_action_pressed("active_skill"):
		activate_slowmo()
	else:
		deactivate_slowmo()

func teleport_to_mouse():
	var mouse_pos = get_global_mouse_position()
	global_position = mouse_pos

@onready var skill_timer: Timer = $skill_timer
var can_teleport : bool = true

func start_cooldown():
	can_teleport = false
	print("Teleport on cooldown!")
	skill_timer.start()

func _on_skill_timer_timeout() -> void:
	can_teleport = true
	print("Teleport ready again!")


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and Input.is_action_pressed("active_skill"):
		if can_teleport:
			teleport_to_mouse()
			start_cooldown()

	# Zoom in/out with mouse wheel
	"""
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			camera_2d.zoom *= 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			camera_2d.zoom *= 0.9
	"""

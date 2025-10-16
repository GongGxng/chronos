extends "res://player/character.gd"

@export var speed_bonus: int = 20
@export var time_penalty: int = 10
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpuparticles= $GPUParticles2D
@onready var skill_cooldown_bar: ProgressBar = $GUILayer/GUI/skill_cooldown_bar

func _ready():
	movement_speed += speed_bonus
	current_time = max(1, current_time - time_penalty)
	upgrade_character("katana1")
	super._ready()

func _on_hurtbox_hurt(damage, angle, knockback_amount) -> void:
	var tween_blink = get_tree().create_tween()
	tween_blink.tween_method(setshader_blink, 1.0, 0.0, 0.5)
	gpuparticles.restart()
	gpuparticles.emitting = true
	super._on_hurtbox_hurt(damage, angle, knockback_amount)

func setshader_blink(new_intensity: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_intensity)

func start_cooldown():
	skill_cooldown_bar.value = 0
	skill_cooldown_bar.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(skill_cooldown_bar, "value", skill_cooldown_bar.max_value, 10)
	super.start_cooldown()

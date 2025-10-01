extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disablehitbox = $DisablehitTimer

func tempdisable():
    collision.call_deferred("set", "disabled", true)
    disablehitbox.start()
    return damage

func _on_disablehit_timer_timeout():
    collision.call_deferred("set", "disabled", false)
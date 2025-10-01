extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _process(_delta: float) -> void:
    change_canvas_layer()

func change_canvas_layer() -> void:
    if Input.is_action_just_pressed("Esc") and !get_tree().paused:
        canvas_layer.layer = 2
    else:
        canvas_layer.layer = 0

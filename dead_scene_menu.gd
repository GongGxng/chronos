extends Control

func _on_restart_pressed() -> void:
    print("Restarting Scene")
    get_tree().reload_current_scene()

func _on_back_pressed() -> void:
    get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
    print("Going back to Main Menu")

func _on_restart_mouse_entered() -> void:
    print("Restart Button Hovered")

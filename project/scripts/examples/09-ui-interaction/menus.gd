# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleMenus
extends Control

@export var pause_menu: Control
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        get_viewport().set_input_as_handled()
        var paused := not get_tree().paused
        get_tree().paused = paused
        if pause_menu: pause_menu.visible = paused
func resume_game() -> void:
    get_tree().paused = false
    if pause_menu: pause_menu.hide()

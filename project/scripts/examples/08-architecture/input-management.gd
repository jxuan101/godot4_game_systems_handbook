# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleInputManagement
extends Node

func movement_vector() -> Vector2:
    return Input.get_vector("move_left", "move_right", "move_up", "move_down")
func consume_action(action: String) -> bool:
    return Input.is_action_just_pressed(action)
func remap_action(action: String, event: InputEvent) -> void:
    if not InputMap.has_action(action): InputMap.add_action(action)
    InputMap.action_erase_events(action)
    InputMap.action_add_event(action, event)

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDragDrop
extends Control

var dragged_data: Variant = null
func begin_drag(data: Variant) -> void: dragged_data = data
func can_drop() -> bool: return dragged_data != null
func _get_drag_data(_at_position: Vector2) -> Variant:
    return dragged_data
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    return data != null and has_method("receive_drop")
func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if has_method("receive_drop"):
        call("receive_drop", data)
        dragged_data = null
func accept_drop(target: Control) -> bool:
    if dragged_data == null or target == null or not target.has_method("receive_drop"): return false
    target.receive_drop(dragged_data)
    dragged_data = null
    return true
func cancel_drag() -> void: dragged_data = null

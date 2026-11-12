# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleNotifications
extends Control

@export var message_label: Label
var queue: Array[String] = []
var showing := false
func notify(message: String) -> void:
    queue.append(message)
    if not showing: _show_next()
func _show_next() -> void:
    if queue.is_empty(): showing = false; hide(); return
    showing = true; show()
    if message_label: message_label.text = queue.pop_front()
    await get_tree().create_timer(2.5).timeout
    _show_next()

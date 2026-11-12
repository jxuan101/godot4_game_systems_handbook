# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleTooltips
extends Control

@export var title_label: Label
@export var description_label: Label
func show_item(title: String, description: String, at: Vector2) -> void:
    if title_label: title_label.text = title
    if description_label: description_label.text = description
    global_position = at; show()
func hide_tooltip() -> void: hide()

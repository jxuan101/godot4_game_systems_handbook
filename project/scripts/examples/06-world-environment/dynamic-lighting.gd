# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDynamicLighting
extends Node

@export var light: CanvasModulate
@export var day_color := Color(1.0, 1.0, 1.0)
@export var night_color := Color(0.12, 0.16, 0.3)
func set_daylight(amount: float) -> void:
    if light == null: return
    light.color = night_color.lerp(day_color, clampf(amount, 0.0, 1.0))

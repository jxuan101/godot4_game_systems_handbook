# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleTimeManipulation
extends Node

@export var normal_scale := 1.0
@export var slow_scale := 0.35
var slowed := false
func set_slow_motion(enabled: bool) -> void:
    slowed = enabled
    Engine.time_scale = slow_scale if slowed else normal_scale
func _exit_tree() -> void: Engine.time_scale = normal_scale

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleBlockParryDodge
extends Node

@export var parry_window := 0.18
@export var block_reduction := 0.65
var parry_left := 0.0
var blocking := false
func begin_parry() -> void: parry_left = parry_window
func set_blocking(value: bool) -> void: blocking = value
func _process(delta: float) -> void: parry_left = maxf(0.0, parry_left - delta)
func mitigate_damage(amount: float) -> Dictionary:
    if parry_left > 0.0: return {"damage": 0.0, "parried": true}
    return {"damage": amount * (1.0 - block_reduction) if blocking else amount, "parried": false}

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleComboSystem
extends Node

@export var combo_window := 0.8
@export var combo_steps := 3
var combo_index := 0
var combo_timer := 0.0
func _process(delta: float) -> void:
    if combo_timer > 0.0:
        combo_timer -= delta
        if combo_timer <= 0.0: combo_index = 0
func register_attack() -> int:
    if combo_timer <= 0.0: combo_index = 0
    combo_index = (combo_index % combo_steps) + 1
    combo_timer = combo_window
    return combo_index
func reset_combo() -> void:
    combo_index = 0
    combo_timer = 0.0

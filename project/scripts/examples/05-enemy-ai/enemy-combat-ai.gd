# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemyCombatAi
extends Node

@export var attack_range := 48.0
@export var preferred_range := 100.0
func choose_action(distance: float, health_ratio: float) -> String:
    if distance <= attack_range: return "attack"
    if health_ratio < 0.25 and distance < preferred_range * 2.0: return "retreat"
    if distance > preferred_range: return "approach"
    return "strafe"

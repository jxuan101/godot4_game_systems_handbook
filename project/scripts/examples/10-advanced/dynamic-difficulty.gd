# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDynamicDifficulty
extends Node

@export var target_success_rate := 0.65
@export var adjustment_speed := 0.08
var difficulty := 1.0
func update_from_attempts(successes: int, attempts: int) -> float:
    if attempts <= 0: return difficulty
    var rate := float(successes) / float(attempts)
    var error := target_success_rate - rate
    difficulty = clampf(difficulty + error * adjustment_speed, 0.5, 2.0)
    return difficulty

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleBossAi
extends Node

@export var phase_thresholds: Array[float] = [0.66, 0.33]
var phase := 0
func update_phase(health: float, maximum: float) -> int:
    if maximum <= 0.0: return phase
    var ratio := health / maximum
    while phase < phase_thresholds.size() and ratio <= phase_thresholds[phase]: phase += 1
    return phase
func choose_pattern(patterns: Array[String], rng: RandomNumberGenerator) -> String:
    return "" if patterns.is_empty() else patterns[rng.randi_range(0, patterns.size()-1)]

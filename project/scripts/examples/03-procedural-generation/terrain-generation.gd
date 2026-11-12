# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleTerrainGeneration
extends Node

@export var width := 64
@export var height := 32
@export var base_height := 16
@export var amplitude := 6
func generate(seed_value: int) -> PackedInt32Array:
    var rng := RandomNumberGenerator.new()
    rng.seed = seed_value
    var result := PackedInt32Array()
    var level := base_height
    for x in range(width):
        level = clampi(level + rng.randi_range(-1, 1), base_height - amplitude, base_height + amplitude)
        result.append(level)
    return result

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleCaveGeneration
extends Node

@export var width := 64
@export var height := 40
@export_range(0.0, 1.0) var fill_chance := 0.46
func generate(seed_value: int, iterations := 4) -> Array:
    var rng := RandomNumberGenerator.new()
    rng.seed = seed_value
    var cells: Array = []
    for y in range(height):
        var row: Array = []
        for x in range(width): row.append(1 if rng.randf() < fill_chance else 0)
        cells.append(row)
    for _i in range(iterations):
        var next: Array = []
        for y in range(height):
            var row: Array = []
            for x in range(width):
                var walls := 0
                for oy in range(-1, 2):
                    for ox in range(-1, 2):
                        var nx := x + ox; var ny := y + oy
                        if nx < 0 or ny < 0 or nx >= width or ny >= height or cells[ny][nx] == 1: walls += 1
                row.append(1 if walls >= 5 else 0)
            next.append(row)
        cells = next
    return cells

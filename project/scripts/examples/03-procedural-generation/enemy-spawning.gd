# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemySpawning
extends Node

@export var min_distance := 180.0
@export var max_attempts := 30
func find_spawn(origin: Vector2, bounds: Rect2, occupied: Array[Vector2], rng: RandomNumberGenerator) -> Vector2:
    for _i in range(max_attempts):
        var p := Vector2(rng.randf_range(bounds.position.x, bounds.end.x), rng.randf_range(bounds.position.y, bounds.end.y))
        if p.distance_to(origin) < min_distance: continue
        var valid := true
        for other in occupied:
            if p.distance_to(other) < min_distance: valid = false; break
        if valid: return p
    return Vector2.INF

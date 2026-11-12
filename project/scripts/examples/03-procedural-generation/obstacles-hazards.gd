# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleObstaclesHazards
extends Node

func place_hazards(candidates: Array[Vector2], safe_points: Array[Vector2], min_clearance: float) -> Array[Vector2]:
    var result: Array[Vector2] = []
    for point in candidates:
        var safe := true
        for safe_point in safe_points:
            if point.distance_to(safe_point) < min_clearance: safe = false; break
        if safe: result.append(point)
    return result

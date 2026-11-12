# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSquadAi
extends Node

func assign_roles(enemies: Array[Node2D], target: Vector2) -> Dictionary:
    var result := {"front": [], "flank": [], "support": []}
    enemies.sort_custom(func(a, b): return a.global_position.distance_squared_to(target) < b.global_position.distance_squared_to(target))
    for i in range(enemies.size()):
        var role := "front" if i < 2 else ("flank" if i < 4 else "support")
        result[role].append(enemies[i])
    return result

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemyPatrol
extends Node2D

@export var patrol_points: Array[Vector2] = []
@export var speed := 90.0
var target_index := 0
func _process(delta: float) -> void:
    if patrol_points.is_empty(): return
    var target := patrol_points[target_index]
    global_position = global_position.move_toward(target, speed * delta)
    if global_position.distance_to(target) < 2.0: target_index = (target_index + 1) % patrol_points.size()

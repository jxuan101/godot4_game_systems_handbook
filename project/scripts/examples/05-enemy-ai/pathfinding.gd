# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePathfinding
extends Node

func find_path(map: AStarGrid2D, from_cell: Vector2i, to_cell: Vector2i) -> PackedVector2Array:
    if not map.is_in_boundsv(from_cell) or not map.is_in_boundsv(to_cell): return PackedVector2Array()
    if map.is_point_solid(from_cell) or map.is_point_solid(to_cell): return PackedVector2Array()
    return map.get_point_path(from_cell, to_cell)

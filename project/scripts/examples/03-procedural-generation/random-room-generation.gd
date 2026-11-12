# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRandomRoomGeneration
extends Node

@export var min_size := Vector2i(5, 5)
@export var max_size := Vector2i(12, 10)
func make_room(rng: RandomNumberGenerator, bounds: Rect2i) -> Rect2i:
    var size := Vector2i(rng.randi_range(min_size.x, max_size.x), rng.randi_range(min_size.y, max_size.y))
    size.x = mini(size.x, bounds.size.x); size.y = mini(size.y, bounds.size.y)
    var pos := Vector2i(rng.randi_range(bounds.position.x, bounds.end.x-size.x), rng.randi_range(bounds.position.y, bounds.end.y-size.y))
    return Rect2i(pos, size)

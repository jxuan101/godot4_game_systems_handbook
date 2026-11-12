# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDungeonGeneration
extends Node

@export var room_count := 12
@export var map_size := Vector2i(80, 60)
func generate(seed_value: int) -> Array[Rect2i]:
    var rng := RandomNumberGenerator.new(); rng.seed = seed_value
    var rooms: Array[Rect2i] = []
    for _i in range(room_count * 12):
        if rooms.size() >= room_count: break
        var size := Vector2i(rng.randi_range(6, 12), rng.randi_range(6, 10))
        var pos := Vector2i(rng.randi_range(1, map_size.x-size.x-1), rng.randi_range(1, map_size.y-size.y-1))
        var candidate := Rect2i(pos, size)
        var overlaps := false
        for room in rooms:
            if candidate.grow(1).intersects(room): overlaps = true; break
        if not overlaps: rooms.append(candidate)
    return rooms

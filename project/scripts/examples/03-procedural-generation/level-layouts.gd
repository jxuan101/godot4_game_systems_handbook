# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleLevelLayouts
extends Node

func connect_rooms(rooms: Array[Rect2i]) -> Array[Vector2i]:
    var corridors: Array[Vector2i] = []
    if rooms.is_empty(): return corridors
    var centers: Array[Vector2i] = []
    for room in rooms: centers.append(room.get_center())
    for i in range(1, centers.size()):
        var a := centers[i-1]; var b := centers[i]
        var p := a
        while p.x != b.x:
            corridors.append(p); p.x += 1 if b.x > p.x else -1
        while p.y != b.y:
            corridors.append(p); p.y += 1 if b.y > p.y else -1
        corridors.append(b)
    return corridors

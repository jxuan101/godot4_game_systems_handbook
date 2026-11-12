# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleChunkLoading
extends Node2D

@export var chunk_size := 512.0
@export var radius := 2
@export var chunk_scene: PackedScene
var loaded: Dictionary = {}
func update_chunks(world_position: Vector2) -> void:
    var center := Vector2i(floori(world_position.x / chunk_size), floori(world_position.y / chunk_size))
    var needed := {}
    for y in range(center.y-radius, center.y+radius+1):
        for x in range(center.x-radius, center.x+radius+1):
            var key := Vector2i(x, y); needed[key] = true
            if not loaded.has(key) and chunk_scene:
                var chunk := chunk_scene.instantiate(); add_child(chunk)
                chunk.position = Vector2(key) * chunk_size; loaded[key] = chunk
    for key in loaded.keys():
        if not needed.has(key): loaded[key].queue_free(); loaded.erase(key)

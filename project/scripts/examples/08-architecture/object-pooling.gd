# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleObjectPooling
extends Node

@export var packed_scene: PackedScene
@export var initial_size := 12
var available: Array[Node] = []
func _ready() -> void:
    for _i in range(initial_size): _create_one()
func _create_one() -> Node:
    if packed_scene == null: return null
    var item := packed_scene.instantiate(); add_child(item); item.set_process(false); item.hide(); available.append(item); return item
func acquire() -> Node:
    if available.is_empty(): _create_one()
    if available.is_empty(): return null
    var item: Node = available.pop_back(); item.show(); item.set_process(true); return item
func release(item: Node) -> void:
    if not is_instance_valid(item) or available.has(item): return
    item.set_process(false); item.hide(); available.append(item)

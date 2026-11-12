# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePerception
extends Area2D

signal target_seen(target: Node2D)
signal target_lost(target: Node2D)
var visible_targets: Array[Node2D] = []
func _ready() -> void:
    body_entered.connect(_on_enter); body_exited.connect(_on_exit)
func _on_enter(body: Node2D) -> void:
    if body.is_in_group("player") and not visible_targets.has(body): visible_targets.append(body); target_seen.emit(body)
func _on_exit(body: Node2D) -> void:
    if visible_targets.has(body): visible_targets.erase(body); target_lost.emit(body)
func get_closest_target() -> Node2D:
    var best: Node2D = null
    for target in visible_targets:
        if not is_instance_valid(target): continue
        if best == null or global_position.distance_squared_to(target.global_position) < global_position.distance_squared_to(best.global_position): best = target
    return best

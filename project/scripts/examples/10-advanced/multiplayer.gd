# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleMultiplayer
extends Node

@export var authority_peer_id := 1
func is_local_authority() -> bool: return multiplayer.get_unique_id() == authority_peer_id
@rpc("authority", "call_local", "reliable")
func apply_state(position: Vector2, health: float) -> void:
    var actor := get_parent()
    if actor is Node2D: actor.global_position = position
    if actor.has_method("set_health"): actor.set_health(health)
func publish_state(position: Vector2, health: float) -> void:
    if is_local_authority(): apply_state.rpc(position, health)

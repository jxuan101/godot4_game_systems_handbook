# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleGrapplingHook
extends Node2D

@export var max_distance := 420.0
@export var pull_acceleration := 900.0
var anchor := Vector2.ZERO
var attached := false
func attach_to(world_point: Vector2, player_position: Vector2) -> bool:
    if player_position.distance_to(world_point) > max_distance: return false
    anchor = world_point
    attached = true
    return true
func detach() -> void: attached = false
func apply_rope_force(body: CharacterBody2D, delta: float) -> void:
    if not attached: return
    var offset := anchor - body.global_position
    var distance := offset.length()
    if distance > 0.001 and distance >= max_distance:
        var outward_speed := body.velocity.dot(-offset.normalized())
        if outward_speed > 0.0:
            body.velocity += offset.normalized() * outward_speed
        body.velocity += offset.normalized() * pull_acceleration * delta

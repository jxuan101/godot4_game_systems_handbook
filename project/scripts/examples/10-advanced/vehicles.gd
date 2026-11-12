# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleVehicles
extends CharacterBody2D

@export var acceleration := 500.0
@export var max_speed := 420.0
@export var drag := 220.0
@export var turn_speed := 3.0
func _physics_process(delta: float) -> void:
    var throttle := Input.get_axis("move_back", "move_forward")
    var steering := Input.get_axis("move_left", "move_right")
    rotation += steering * turn_speed * delta * clampf(velocity.length() / max_speed, 0.2, 1.0)
    velocity += Vector2.UP.rotated(rotation) * throttle * acceleration * delta
    velocity = velocity.move_toward(Vector2.ZERO, drag * delta)
    if velocity.length() > max_speed: velocity = velocity.normalized() * max_speed
    move_and_slide()

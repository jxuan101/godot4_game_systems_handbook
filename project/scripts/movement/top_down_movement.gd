class_name TopDownMovement
extends Node

@export var speed := 220.0
@export var acceleration := 1400.0
@export var use_acceleration := true
var body: CharacterBody2D

func _ready() -> void:
    body = get_parent() as CharacterBody2D
    assert(body != null)

func physics_step(delta: float, input_vector: Vector2) -> void:
    var direction := input_vector.normalized()
    var target := direction * speed
    if use_acceleration:
        body.velocity = body.velocity.move_toward(target, acceleration * delta)
    else:
        body.velocity = target
    body.move_and_slide()

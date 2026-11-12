# Godot 4 example. Attach to a node of the declared base type.
class_name Example3DCharacterMovement
extends CharacterBody3D

@export var speed := 5.5
@export var acceleration := 18.0
@export var jump_velocity := 4.5
@export var gravity := 12.0
func _physics_process(delta: float) -> void:
    var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction := (transform.basis * Vector3(input.x, 0.0, input.y)).normalized()
    velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
    velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
    if not is_on_floor(): velocity.y -= gravity * delta
    elif Input.is_action_just_pressed("jump"): velocity.y = jump_velocity
    move_and_slide()

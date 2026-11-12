# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDoubleJump
extends CharacterBody2D

@export var jump_velocity := -420.0
@export var extra_jumps := 1
var jumps_left := 1
func _physics_process(delta: float) -> void:
    if is_on_floor(): jumps_left = extra_jumps
    if not is_on_floor(): velocity.y += 1100.0 * delta
    if Input.is_action_just_pressed("jump"):
        if is_on_floor(): velocity.y = jump_velocity
        elif jumps_left > 0:
            velocity.y = jump_velocity
            jumps_left -= 1
    velocity.x = Input.get_axis("move_left", "move_right") * 240.0
    move_and_slide()

# Godot 4 example. Attach to a node of the declared base type.
class_name Example2DPlatformerMovement
extends CharacterBody2D

@export var speed := 260.0
@export var acceleration := 1800.0
@export var friction := 2200.0
@export var jump_velocity := -420.0
@export var gravity := 1100.0
@export var coyote_time := 0.12
@export var jump_buffer := 0.12
var coyote_left := 0.0
var jump_left := 0.0
func _physics_process(delta: float) -> void:
    var axis := Input.get_axis("move_left", "move_right")
    velocity.x = move_toward(velocity.x, axis * speed, (acceleration if axis != 0.0 else friction) * delta)
    if is_on_floor(): coyote_left = coyote_time
    else:
        coyote_left = maxf(0.0, coyote_left - delta)
        velocity.y += gravity * delta
    if Input.is_action_just_pressed("jump"): jump_left = jump_buffer
    else: jump_left = maxf(0.0, jump_left - delta)
    if jump_left > 0.0 and coyote_left > 0.0:
        velocity.y = jump_velocity
        jump_left = 0.0
        coyote_left = 0.0
    if Input.is_action_just_released("jump") and velocity.y < 0.0: velocity.y *= 0.5
    move_and_slide()

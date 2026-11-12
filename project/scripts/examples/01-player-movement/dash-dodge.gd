# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDashDodge
extends CharacterBody2D

@export var dash_speed := 720.0
@export var dash_duration := 0.16
@export var cooldown := 0.7
var dash_left := 0.0
var cooldown_left := 0.0
var dash_direction := Vector2.RIGHT
func _physics_process(delta: float) -> void:
    cooldown_left = maxf(0.0, cooldown_left - delta)
    if dash_left > 0.0:
        dash_left -= delta
        velocity = dash_direction * dash_speed
    else:
        var axis := Input.get_vector("move_left", "move_right", "move_up", "move_down")
        if Input.is_action_just_pressed("dash") and cooldown_left == 0.0:
            dash_direction = axis.normalized() if axis != Vector2.ZERO else Vector2.RIGHT
            dash_left = dash_duration
            cooldown_left = cooldown
        else: velocity = axis * 240.0
    move_and_slide()

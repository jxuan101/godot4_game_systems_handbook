# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleWallJumpClimb
extends CharacterBody2D

@export var climb_speed := 120.0
@export var wall_jump := Vector2(300.0, -420.0)
func _physics_process(delta: float) -> void:
    if not is_on_floor(): velocity.y += 1100.0 * delta
    if is_on_wall() and Input.is_action_pressed("climb"):
        velocity.y = Input.get_axis("move_up", "move_down") * climb_speed
    if is_on_wall_only() and Input.is_action_just_pressed("jump"):
        velocity = Vector2(-get_wall_normal().x * wall_jump.x, wall_jump.y)
    velocity.x = Input.get_axis("move_left", "move_right") * 220.0
    move_and_slide()

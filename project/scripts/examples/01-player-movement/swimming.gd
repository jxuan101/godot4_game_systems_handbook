# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSwimming
extends CharacterBody2D

@export var swim_speed := 180.0
@export var water_gravity_scale := 0.25
var in_water := false
func set_in_water(value: bool) -> void: in_water = value
func _physics_process(delta: float) -> void:
    var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity.x = direction.x * swim_speed
    velocity.y = move_toward(velocity.y, direction.y * swim_speed, 600.0 * delta)
    if not in_water and not is_on_floor(): velocity.y += 1100.0 * delta
    elif in_water: velocity.y += 1100.0 * water_gravity_scale * delta
    move_and_slide()

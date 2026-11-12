# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleTopDownMovement
extends CharacterBody2D

@export var speed := 240.0
@export var acceleration := 1400.0
func _physics_process(delta: float) -> void:
    var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = velocity.move_toward(direction * speed, acceleration * delta)
    move_and_slide()

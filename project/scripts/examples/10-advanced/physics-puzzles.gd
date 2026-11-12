# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePhysicsPuzzles
extends RigidBody2D

@export var required_mass := 5.0
@export var activation_delay := 0.2
signal puzzle_activated
var weighted_bodies: Array[RigidBody2D] = []
var activated := false
func _physics_process(_delta: float) -> void:
    var total := 0.0
    for body in weighted_bodies:
        if is_instance_valid(body): total += body.mass
    if not activated and total >= required_mass:
        activated = true
        get_tree().create_timer(activation_delay).timeout.connect(func(): puzzle_activated.emit())

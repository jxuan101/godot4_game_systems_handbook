# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnvironmentHazards
extends Area2D

@export var damage_per_second := 8.0
var bodies: Array[Node2D] = []
func _ready() -> void: body_entered.connect(_enter); body_exited.connect(_exit)
func _enter(body: Node2D) -> void:
    if body.has_method("take_damage"): bodies.append(body)
func _exit(body: Node2D) -> void: bodies.erase(body)
func _physics_process(delta: float) -> void:
    for body in bodies:
        if is_instance_valid(body): body.take_damage(damage_per_second * delta)

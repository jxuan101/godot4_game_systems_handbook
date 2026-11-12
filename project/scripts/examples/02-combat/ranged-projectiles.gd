# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRangedProjectiles
extends Area2D

@export var speed := 600.0
@export var damage := 12.0
@export var lifetime := 3.0
var direction := Vector2.RIGHT
func launch(from_position: Vector2, toward: Vector2) -> void:
    global_position = from_position
    direction = (toward - from_position).normalized()
    rotation = direction.angle()
func _ready() -> void:
    body_entered.connect(_on_body_entered)
    get_tree().create_timer(lifetime).timeout.connect(queue_free)
func _physics_process(delta: float) -> void: global_position += direction * speed * delta
func _on_body_entered(body: Node2D) -> void:
    if body.has_method("take_damage"): body.take_damage(damage)
    queue_free()

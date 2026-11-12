class_name Projectile
extends Area2D

@export var speed := 500.0
@export var lifetime := 3.0
@export var damage := 10.0
var direction := Vector2.RIGHT
var _age := 0.0

func setup(fire_direction: Vector2, projectile_speed := -1.0) -> void:
    direction = fire_direction.normalized()
    if projectile_speed > 0.0:
        speed = projectile_speed

func _physics_process(delta: float) -> void:
    global_position += direction * speed * delta
    _age += delta
    if _age >= lifetime:
        queue_free()

func _on_body_entered(body: Node2D) -> void:
    if body.has_method("apply_damage"):
        body.apply_damage(damage)
    queue_free()

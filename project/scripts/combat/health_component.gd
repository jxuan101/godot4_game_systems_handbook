class_name HealthComponent
extends Node

signal health_changed(current: float, maximum: float)
signal died

@export var max_health := 100.0
var current_health: float

func _ready() -> void:
    current_health = max_health
    health_changed.emit(current_health, max_health)

func apply_damage(amount: float) -> void:
    if amount <= 0.0 or current_health <= 0.0:
        return
    current_health = maxf(0.0, current_health - amount)
    health_changed.emit(current_health, max_health)
    if is_zero_approx(current_health):
        died.emit()

func heal(amount: float) -> void:
    if amount <= 0.0 or current_health <= 0.0:
        return
    current_health = minf(max_health, current_health + amount)
    health_changed.emit(current_health, max_health)

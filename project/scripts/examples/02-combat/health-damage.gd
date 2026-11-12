# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHealthDamage
extends Node

signal health_changed(current: float, maximum: float)
signal died
@export var maximum_health := 100.0
var health := 100.0
var invulnerable := false
func _ready() -> void: health = maximum_health
func take_damage(amount: float) -> bool:
    if amount <= 0.0 or invulnerable or health <= 0.0: return false
    health = maxf(0.0, health - amount)
    health_changed.emit(health, maximum_health)
    if health == 0.0: died.emit()
    return true
func heal(amount: float) -> void:
    if amount <= 0.0 or health <= 0.0: return
    health = minf(maximum_health, health + amount)
    health_changed.emit(health, maximum_health)

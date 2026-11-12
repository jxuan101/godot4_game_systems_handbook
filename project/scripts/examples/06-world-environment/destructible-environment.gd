# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDestructibleEnvironment
extends StaticBody2D

signal destroyed
@export var hit_points := 3
var current_hp := 3
func _ready() -> void: current_hp = hit_points
func apply_hit(power: int = 1) -> void:
    if current_hp <= 0: return
    current_hp = maxi(0, current_hp - maxi(1, power))
    if current_hp == 0:
        destroyed.emit()
        queue_free()

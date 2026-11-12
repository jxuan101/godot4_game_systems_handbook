# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleExperienceLeveling
extends Node

signal level_up(level: int)
@export var base_xp := 100
var level := 1
var xp := 0
func xp_to_next() -> int: return base_xp * level
func add_xp(amount: int) -> void:
    xp += maxi(0, amount)
    while xp >= xp_to_next():
        xp -= xp_to_next(); level += 1; level_up.emit(level)

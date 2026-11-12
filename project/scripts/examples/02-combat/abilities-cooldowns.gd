# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleAbilitiesCooldowns
extends Node

signal ability_ready(ability_id: String)
var cooldowns: Dictionary = {}
func start_cooldown(id: String, seconds: float) -> void:
    cooldowns[id] = maxf(0.0, seconds)
func is_ready(id: String) -> bool: return float(cooldowns.get(id, 0.0)) <= 0.0
func _process(delta: float) -> void:
    for id in cooldowns.keys():
        var previous := float(cooldowns[id])
        cooldowns[id] = maxf(0.0, previous - delta)
        if previous > 0.0 and cooldowns[id] == 0.0:
            ability_ready.emit(str(id))

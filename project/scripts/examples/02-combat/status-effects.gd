# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleStatusEffects
extends Node

signal effects_changed
var effects: Dictionary = {}
func apply_effect(id: String, duration: float, damage_per_second := 0.0) -> void:
    effects[id] = {"time": duration, "dps": damage_per_second}
    effects_changed.emit()
func _process(delta: float) -> void:
    for id in effects.keys():
        var effect: Dictionary = effects[id]
        effect.time = float(effect.time) - delta
        if effect.time <= 0.0: effects.erase(id)
        else: effects[id] = effect
func damage_over_time(delta: float) -> float:
    var total := 0.0
    for effect in effects.values(): total += float(effect.dps) * delta
    return total

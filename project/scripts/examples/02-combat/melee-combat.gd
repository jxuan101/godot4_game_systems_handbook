# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleMeleeCombat
extends Node

signal attack_started
signal attack_finished
@export var attack_cooldown := 0.35
@export var damage := 20.0
var ready_to_attack := true
func attack(targets: Array[Node]) -> bool:
    if not ready_to_attack: return false
    ready_to_attack = false
    attack_started.emit()
    for target in targets:
        if is_instance_valid(target) and target.has_method("take_damage"): target.take_damage(damage)
    get_tree().create_timer(attack_cooldown).timeout.connect(_reset_attack)
    return true
func _reset_attack() -> void:
    ready_to_attack = true
    attack_finished.emit()

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHitboxesHurtboxes
extends Area2D

@export var damage := 10.0
@export var team_id := 0
var already_hit: Array[Node] = []
func _ready() -> void: area_entered.connect(_on_area_entered)
func _on_area_entered(area: Area2D) -> void:
    if area == self or already_hit.has(area): return
    var receiver := area.get_parent()
    if receiver == null or not receiver.has_method("take_damage"): return
    if receiver.get("team_id") == team_id: return
    already_hit.append(area)
    receiver.take_damage(damage)
func reset_hits() -> void: already_hit.clear()

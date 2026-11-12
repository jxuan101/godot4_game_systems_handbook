# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleProceduralMissions
extends Node

@export var mission_templates: Array[Dictionary] = []
func create_mission(rng: RandomNumberGenerator) -> Dictionary:
    if mission_templates.is_empty(): return {}
    var mission: Dictionary = mission_templates[rng.randi_range(0, mission_templates.size()-1)].duplicate(true)
    mission["seed"] = rng.randi()
    mission["generated_at"] = Time.get_unix_time_from_system()
    return mission

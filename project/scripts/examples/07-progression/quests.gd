# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleQuests
extends Node

signal quest_updated(id: String, state: String)
var quests: Dictionary = {}
func start_quest(id: String, objectives: Dictionary) -> void:
    quests[id] = {"objectives": objectives.duplicate(true), "complete": false}; quest_updated.emit(id, "started")
func add_progress(id: String, objective: String, amount := 1) -> void:
    if not quests.has(id): return
    var objectives: Dictionary = quests[id].objectives
    if not objectives.has(objective): return
    objectives[objective] = maxi(0, int(objectives[objective]) - amount)
    if objectives.values().all(func(v): return int(v) <= 0): quests[id].complete = true; quest_updated.emit(id, "completed")

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleFactionsReputation
extends Node

signal reputation_changed(faction: String, value: int)
var reputation: Dictionary = {}
func add_reputation(faction: String, amount: int) -> int:
    var value := clampi(int(reputation.get(faction, 0)) + amount, -100, 100)
    reputation[faction] = value; reputation_changed.emit(faction, value); return value
func standing(faction: String) -> String:
    var value := int(reputation.get(faction, 0))
    return "hostile" if value <= -50 else ("friendly" if value >= 50 else "neutral")

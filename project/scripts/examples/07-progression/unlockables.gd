# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleUnlockables
extends Node

var unlocked: Dictionary = {}
func evaluate_unlock(id: String, requirements: Array[String], flags: Dictionary) -> bool:
    if unlocked.has(id): return true
    for requirement in requirements:
        if not bool(flags.get(requirement, false)): return false
    unlocked[id] = true
    return true

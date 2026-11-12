# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSkillTrees
extends Node

var unlocked: Dictionary = {}
func can_unlock(skill: Dictionary) -> bool:
    for prerequisite in skill.get("requires", []):
        if not unlocked.has(prerequisite): return false
    return true
func unlock(skill: Dictionary) -> bool:
    var id := str(skill.get("id", ""))
    if id.is_empty() or unlocked.has(id) or not can_unlock(skill): return false
    unlocked[id] = true
    return true

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleAchievements
extends Node

signal achievement_unlocked(id: String)
var unlocked: Dictionary = {}
func unlock(id: String) -> bool:
    if id.is_empty() or unlocked.has(id): return false
    unlocked[id] = Time.get_unix_time_from_system()
    achievement_unlocked.emit(id)
    return true
func is_unlocked(id: String) -> bool: return unlocked.has(id)

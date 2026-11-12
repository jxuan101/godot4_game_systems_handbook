# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSaveLoad
extends Node

@export var save_path := "user://savegame.json"
func save_data(data: Dictionary) -> bool:
    var file := FileAccess.open(save_path, FileAccess.WRITE)
    if file == null: return false
    file.store_string(JSON.stringify(data)); return true
func load_data() -> Dictionary:
    if not FileAccess.file_exists(save_path): return {}
    var file := FileAccess.open(save_path, FileAccess.READ)
    if file == null: return {}
    var parsed = JSON.parse_string(file.get_as_text())
    return parsed if parsed is Dictionary else {}

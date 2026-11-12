# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSceneManagement
extends Node

var history: Array[String] = []
func go_to(path: String):
    if not ResourceLoader.exists(path): return ERR_FILE_NOT_FOUND
    var current := get_tree().current_scene
    if current: history.append(current.scene_file_path)
    return get_tree().change_scene_to_file(path)
func go_back():
    if history.is_empty(): return ERR_DOES_NOT_EXIST
    return get_tree().change_scene_to_file(history.pop_back())

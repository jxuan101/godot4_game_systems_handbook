# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleWorldTransitions
extends Node

signal transition_started
signal transition_finished
@export var fade_seconds := 0.25
var busy := false
func change_scene(path: String) -> void:
    if busy or not ResourceLoader.exists(path): return
    busy = true; transition_started.emit()
    await get_tree().create_timer(fade_seconds).timeout
    var error := get_tree().change_scene_to_file(path)
    if error != OK: busy = false; return
    await get_tree().process_frame
    transition_finished.emit(); busy = false

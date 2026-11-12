# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDialogue
extends Node

signal line_changed(speaker: String, text: String)
signal dialogue_finished
var lines: Array[Dictionary] = []
var index := -1
func start_dialogue(data: Array[Dictionary]) -> void:
    lines = data; index = -1; next_line()
func next_line() -> void:
    index += 1
    if index >= lines.size(): dialogue_finished.emit(); return
    var line := lines[index]
    line_changed.emit(str(line.get("speaker", "")), str(line.get("text", "")))

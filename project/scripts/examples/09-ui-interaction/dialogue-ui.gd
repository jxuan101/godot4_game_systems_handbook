# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDialogueUi
extends Control

@export var speaker_label: Label
@export var body_label: RichTextLabel
func show_line(speaker: String, text: String) -> void:
    if speaker_label: speaker_label.text = speaker
    if body_label: body_label.text = text
func clear_dialogue() -> void:
    if speaker_label: speaker_label.text = ""
    if body_label: body_label.text = ""

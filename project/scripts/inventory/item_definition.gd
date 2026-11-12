class_name ItemDefinition
extends Resource

@export var item_id: StringName
@export var display_name := ""
@export_multiline var description := ""
@export var icon: Texture2D
@export_range(1, 999) var max_stack := 99
@export var value := 0

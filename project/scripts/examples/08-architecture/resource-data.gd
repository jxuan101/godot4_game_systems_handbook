# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleResourceData
extends Resource

@export var item_id := ""
@export var display_name := "Unnamed"
@export_multiline var description := ""
@export var max_stack := 1
@export var base_value := 0
func is_valid_definition() -> bool:
    return not item_id.is_empty() and max_stack > 0 and base_value >= 0

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleComponentArchitecture
extends Node

func get_component(owner: Node, component_name: String) -> Node:
    if owner == null: return null
    for child in owner.get_children():
        if child.name == component_name: return child
    return null
func require_method(component: Node, method_name: String) -> bool:
    return component != null and component.has_method(method_name)

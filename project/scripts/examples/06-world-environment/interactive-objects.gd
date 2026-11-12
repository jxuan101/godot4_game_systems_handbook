# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleInteractiveObjects
extends Area2D

signal interacted(actor: Node)
@export var one_shot := false
var used := false
func interact(actor: Node) -> bool:
    if used and one_shot: return false
    used = true
    interacted.emit(actor)
    return true

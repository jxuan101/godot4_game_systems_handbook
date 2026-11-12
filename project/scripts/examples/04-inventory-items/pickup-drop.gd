# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePickupDrop
extends Area2D

signal picked_up(item: Dictionary)
@export var item_data: Dictionary = {"id": "coin", "count": 1}
func _ready() -> void: body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
    if body.has_method("add_item") and body.add_item(item_data):
        picked_up.emit(item_data)
        queue_free()

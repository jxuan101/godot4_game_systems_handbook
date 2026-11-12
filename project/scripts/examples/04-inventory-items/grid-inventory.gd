# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleGridInventory
extends Node

signal inventory_changed
@export var columns := 6
@export var rows := 4
var cells: Array = []
func _ready() -> void:
    cells.resize(columns * rows)
    cells.fill(null)
func insert(item: Dictionary, cell: int) -> bool:
    if cell < 0 or cell >= cells.size() or cells[cell] != null: return false
    cells[cell] = item.duplicate(true); inventory_changed.emit(); return true
func remove(cell: int) -> Variant:
    if cell < 0 or cell >= cells.size(): return null
    var item = cells[cell]; cells[cell] = null; inventory_changed.emit(); return item

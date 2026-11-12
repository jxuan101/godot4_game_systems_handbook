# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEquipment
extends Node

signal equipment_changed(slot: String, item: Variant)
var equipped: Dictionary = {}
func equip(slot: String, item: Dictionary) -> Variant:
    if not item.has("slot") or str(item.slot) != slot: return null
    var previous = equipped.get(slot)
    equipped[slot] = item.duplicate(true)
    equipment_changed.emit(slot, equipped[slot])
    return previous
func unequip(slot: String) -> Variant:
    var previous = equipped.get(slot)
    equipped.erase(slot); equipment_changed.emit(slot, null); return previous

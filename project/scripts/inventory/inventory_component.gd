class_name InventoryComponent
extends Node

signal inventory_changed

@export_range(1, 200) var capacity := 20
# Runtime entries: {"item": ItemDefinition, "quantity": int}
var slots: Array[Dictionary] = []

func add_item(item: ItemDefinition, quantity: int) -> int:
    if item == null or quantity <= 0:
        return quantity
    var remaining := quantity
    for slot in slots:
        if slot.item == item and int(slot.quantity) < item.max_stack:
            var moved := mini(remaining, item.max_stack - int(slot.quantity))
            slot.quantity = int(slot.quantity) + moved
            remaining -= moved
            if remaining == 0:
                inventory_changed.emit()
                return 0
    while remaining > 0 and slots.size() < capacity:
        var moved := mini(remaining, item.max_stack)
        slots.append({"item": item, "quantity": moved})
        remaining -= moved
    inventory_changed.emit()
    return remaining

func remove_item(item: ItemDefinition, quantity: int) -> bool:
    if item == null or quantity <= 0:
        return false
    var total := 0
    for slot in slots:
        if slot.item == item:
            total += int(slot.quantity)
    if total < quantity:
        return false
    var remaining := quantity
    for i in range(slots.size() - 1, -1, -1):
        if slots[i].item != item:
            continue
        var taken := mini(remaining, int(slots[i].quantity))
        slots[i].quantity = int(slots[i].quantity) - taken
        remaining -= taken
        if int(slots[i].quantity) == 0:
            slots.remove_at(i)
        if remaining == 0:
            break
    inventory_changed.emit()
    return true

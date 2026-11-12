# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleItemStacking
extends Node

func add_to_stacks(stacks: Array[Dictionary], item_id: String, amount: int, max_stack: int) -> int:
    if amount <= 0 or max_stack <= 0: return amount
    for stack in stacks:
        if stack.id == item_id and int(stack.count) < max_stack:
            var moved := mini(amount, max_stack - int(stack.count)); stack.count = int(stack.count) + moved; amount -= moved
            if amount == 0: return 0
    while amount > 0:
        var moved := mini(amount, max_stack); stacks.append({"id": item_id, "count": moved}); amount -= moved
    return 0

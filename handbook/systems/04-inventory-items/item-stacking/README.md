# System 03: Item Stacking

**Category:** Inventory & Item Systems  
**Godot node focus:** `Resource`  
**Status:** Working Godot 4 example

## 1. Purpose

Merge compatible stacks up to a maximum stack size.

## 2. Scene architecture

```text
Resource (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/04-inventory-items/item-stacking.gd`](../../../../project/scripts/examples/04-inventory-items/item-stacking.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
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
```

## 4. Reusable design

- Keep tunable values in exported properties or custom Resources.
- Avoid hardcoding the player, current level, or global scene path.
- Emit signals when externally observable state changes.
- Make cleanup explicit when timers, spawned nodes, or subscriptions are involved.
- Use a seeded `RandomNumberGenerator` for reproducible procedural behavior.

## 5. Test checklist

- [ ] Normal case produces the expected result.
- [ ] Disabled or unconfigured system fails safely.
- [ ] Boundary values are handled (zero, maximum, empty collections).
- [ ] Repeated activation does not duplicate work or connections.
- [ ] Removing the owning scene does not leave orphan nodes or callbacks.
- [ ] Public signals fire once and carry correct values.
- [ ] Configuration can be changed without editing the script.

## 6. Integration notes

Add this system to a minimal test scene before connecting it to the full game. Test it with
placeholder art and debug output first. Once stable, connect animation, audio, UI, and save
data through signals or explicit interfaces.

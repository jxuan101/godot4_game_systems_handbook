# System 05: Crafting Systems

**Category:** Inventory & Item Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Validate ingredients, consume inputs, and produce an output item.

## 2. Scene architecture

```text
Node (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/04-inventory-items/crafting.gd`](../../../../project/scripts/examples/04-inventory-items/crafting.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleCrafting
extends Node

func can_craft(inventory: Dictionary, recipe: Dictionary) -> bool:
    for id in recipe.get("ingredients", {}):
        if int(inventory.get(id, 0)) < int(recipe.ingredients[id]): return false
    return true
func craft(inventory: Dictionary, recipe: Dictionary) -> bool:
    if not can_craft(inventory, recipe): return false
    for id in recipe.ingredients: inventory[id] = int(inventory.get(id, 0)) - int(recipe.ingredients[id])
    var output: Dictionary = recipe.get("output", {})
    var out_id := str(output.get("id", ""))
    inventory[out_id] = int(inventory.get(out_id, 0)) + int(output.get("count", 1))
    return true
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

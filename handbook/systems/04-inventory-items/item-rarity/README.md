# System 04: Item Rarity & Attributes

**Category:** Inventory & Item Systems  
**Godot node focus:** `Resource`  
**Status:** Working Godot 4 example

## 1. Purpose

Represent rarity and rolled attributes as data rather than hardcoded branches.

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

The complete example is [`project/scripts/examples/04-inventory-items/item-rarity.gd`](../../../../project/scripts/examples/04-inventory-items/item-rarity.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleItemRarity
extends Node

const MULTIPLIERS := {"common": 1.0, "uncommon": 1.2, "rare": 1.5, "epic": 2.0, "legendary": 3.0}
func roll_rarity(rng: RandomNumberGenerator) -> String:
    var roll := rng.randf()
    if roll < 0.01: return "legendary"
    if roll < 0.06: return "epic"
    if roll < 0.20: return "rare"
    if roll < 0.45: return "uncommon"
    return "common"
func scale_stat(base_value: float, rarity: String) -> float: return base_value * float(MULTIPLIERS.get(rarity, 1.0))
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

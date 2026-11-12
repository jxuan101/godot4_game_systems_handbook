# System 06: Random Loot Generation

**Category:** Procedural Generation  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Choose drops from weighted loot entries.

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

The complete example is [`project/scripts/examples/03-procedural-generation/loot-generation.gd`](../../../../project/scripts/examples/03-procedural-generation/loot-generation.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleLootGeneration
extends Node

func choose_weighted(entries: Array[Dictionary], rng: RandomNumberGenerator) -> Variant:
    var total := 0.0
    for entry in entries: total += maxf(0.0, float(entry.get("weight", 0.0)))
    if total <= 0.0: return null
    var roll := rng.randf() * total
    for entry in entries:
        roll -= maxf(0.0, float(entry.get("weight", 0.0)))
        if roll <= 0.0: return entry.get("item")
    return entries.back().get("item")
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

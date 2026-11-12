# System 06: Blocking, Parrying & Dodging

**Category:** Combat Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Resolve incoming attacks against defensive states and timing windows.

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

The complete example is [`project/scripts/examples/02-combat/block-parry-dodge.gd`](../../../../project/scripts/examples/02-combat/block-parry-dodge.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleBlockParryDodge
extends Node

@export var parry_window := 0.18
@export var block_reduction := 0.65
var parry_left := 0.0
var blocking := false
func begin_parry() -> void: parry_left = parry_window
func set_blocking(value: bool) -> void: blocking = value
func _process(delta: float) -> void: parry_left = maxf(0.0, parry_left - delta)
func mitigate_damage(amount: float) -> Dictionary:
    if parry_left > 0.0: return {"damage": 0.0, "parried": true}
    return {"damage": amount * (1.0 - block_reduction) if blocking else amount, "parried": false}
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

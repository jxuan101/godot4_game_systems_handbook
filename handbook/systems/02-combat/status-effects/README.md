# System 08: Status Effects & Elemental Damage

**Category:** Combat Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Apply timed effects such as burn, slow, poison, and resistance modifiers.

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

The complete example is [`project/scripts/examples/02-combat/status-effects.gd`](../../../../project/scripts/examples/02-combat/status-effects.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleStatusEffects
extends Node

signal effects_changed
var effects: Dictionary = {}
func apply_effect(id: String, duration: float, damage_per_second := 0.0) -> void:
    effects[id] = {"time": duration, "dps": damage_per_second}
    effects_changed.emit()
func _process(delta: float) -> void:
    for id in effects.keys():
        var effect: Dictionary = effects[id]
        effect.time = float(effect.time) - delta
        if effect.time <= 0.0: effects.erase(id)
        else: effects[id] = effect
func damage_over_time(delta: float) -> float:
    var total := 0.0
    for effect in effects.values(): total += float(effect.dps) * delta
    return total
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

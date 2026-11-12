# System 04: Health & Damage

**Category:** Combat Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Health, damage validation, healing, death signaling, and invulnerability.

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

The complete example is [`project/scripts/examples/02-combat/health-damage.gd`](../../../../project/scripts/examples/02-combat/health-damage.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHealthDamage
extends Node

signal health_changed(current: float, maximum: float)
signal died
@export var maximum_health := 100.0
var health := 100.0
var invulnerable := false
func _ready() -> void: health = maximum_health
func take_damage(amount: float) -> bool:
    if amount <= 0.0 or invulnerable or health <= 0.0: return false
    health = maxf(0.0, health - amount)
    health_changed.emit(health, maximum_health)
    if health == 0.0: died.emit()
    return true
func heal(amount: float) -> void:
    if amount <= 0.0 or health <= 0.0: return
    health = minf(maximum_health, health + amount)
    health_changed.emit(health, maximum_health)
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

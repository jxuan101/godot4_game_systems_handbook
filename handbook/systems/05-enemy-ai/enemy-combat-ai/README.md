# System 06: Enemy Combat Behavior

**Category:** Enemy AI  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Choose attacks based on range, cooldown, and target state.

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

The complete example is [`project/scripts/examples/05-enemy-ai/enemy-combat-ai.gd`](../../../../project/scripts/examples/05-enemy-ai/enemy-combat-ai.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemyCombatAi
extends Node

@export var attack_range := 48.0
@export var preferred_range := 100.0
func choose_action(distance: float, health_ratio: float) -> String:
    if distance <= attack_range: return "attack"
    if health_ratio < 0.25 and distance < preferred_range * 2.0: return "retreat"
    if distance > preferred_range: return "approach"
    return "strafe"
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

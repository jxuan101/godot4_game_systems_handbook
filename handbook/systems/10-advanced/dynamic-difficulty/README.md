# System 08: Dynamic Difficulty Adjustment

**Category:** Advanced Gameplay Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Adjust bounded difficulty parameters from player performance signals.

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

The complete example is [`project/scripts/examples/10-advanced/dynamic-difficulty.gd`](../../../../project/scripts/examples/10-advanced/dynamic-difficulty.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDynamicDifficulty
extends Node

@export var target_success_rate := 0.65
@export var adjustment_speed := 0.08
var difficulty := 1.0
func update_from_attempts(successes: int, attempts: int) -> float:
    if attempts <= 0: return difficulty
    var rate := float(successes) / float(attempts)
    var error := target_success_rate - rate
    difficulty = clampf(difficulty + error * adjustment_speed, 0.5, 2.0)
    return difficulty
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

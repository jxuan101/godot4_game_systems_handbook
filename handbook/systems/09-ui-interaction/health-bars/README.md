# System 08: Dynamic Health & Stamina Bars

**Category:** UI & Interaction  
**Godot node focus:** `ProgressBar`  
**Status:** Working Godot 4 example

## 1. Purpose

Bind progress bars to actor signals and clamp displayed values.

## 2. Scene architecture

```text
ProgressBar (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/09-ui-interaction/health-bars.gd`](../../../../project/scripts/examples/09-ui-interaction/health-bars.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `ProgressBar` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHealthBars
extends ProgressBar

@export var smoothing := 8.0
var target_value := 100.0
func set_health(current: float, maximum: float) -> void:
    max_value = maxf(1.0, maximum)
    target_value = clampf(current, 0.0, max_value)
func _process(delta: float) -> void:
    value = move_toward(value, target_value, smoothing * max_value * delta)
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

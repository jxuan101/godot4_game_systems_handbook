# System 02: Stealth & Visibility

**Category:** Advanced Gameplay Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Calculate visibility from distance, occlusion, lighting, and actor stance.

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

The complete example is [`project/scripts/examples/10-advanced/stealth.gd`](../../../../project/scripts/examples/10-advanced/stealth.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleStealth
extends Node

@export var visibility_radius := 240.0
@export var crouch_multiplier := 0.45
func visibility_score(observer: Vector2, target: Vector2, is_crouching: bool, light_factor := 1.0) -> float:
    var distance_factor := clampf(1.0 - observer.distance_to(target) / visibility_radius, 0.0, 1.0)
    return distance_factor * (crouch_multiplier if is_crouching else 1.0) * clampf(light_factor, 0.0, 1.0)
func is_detected(score: float, threshold := 0.35) -> bool: return score >= threshold
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

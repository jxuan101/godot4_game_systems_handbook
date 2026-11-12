# System 08: Grappling Hook Movement

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Attach to a grapple point and apply a spring-like pull toward the anchor.

## 2. Scene architecture

```text
CharacterBody2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/01-player-movement/grappling-hook.gd`](../../../../project/scripts/examples/01-player-movement/grappling-hook.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleGrapplingHook
extends Node2D

@export var max_distance := 420.0
@export var pull_acceleration := 900.0
var anchor := Vector2.ZERO
var attached := false
func attach_to(world_point: Vector2, player_position: Vector2) -> bool:
    if player_position.distance_to(world_point) > max_distance: return false
    anchor = world_point
    attached = true
    return true
func detach() -> void: attached = false
func apply_rope_force(body: CharacterBody2D, delta: float) -> void:
    if not attached: return
    var offset := anchor - body.global_position
    var distance := offset.length()
    if distance > 0.001 and distance >= max_distance:
        var outward_speed := body.velocity.dot(-offset.normalized())
        if outward_speed > 0.0:
            body.velocity += offset.normalized() * outward_speed
        body.velocity += offset.normalized() * pull_acceleration * delta
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

# System 07: Enemy Spawning & Distribution

**Category:** Procedural Generation  
**Godot node focus:** `Node2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Spawn enemies at validated spawn markers with density limits.

## 2. Scene architecture

```text
Node2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/03-procedural-generation/enemy-spawning.gd`](../../../../project/scripts/examples/03-procedural-generation/enemy-spawning.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemySpawning
extends Node

@export var min_distance := 180.0
@export var max_attempts := 30
func find_spawn(origin: Vector2, bounds: Rect2, occupied: Array[Vector2], rng: RandomNumberGenerator) -> Vector2:
    for _i in range(max_attempts):
        var p := Vector2(rng.randf_range(bounds.position.x, bounds.end.x), rng.randf_range(bounds.position.y, bounds.end.y))
        if p.distance_to(origin) < min_distance: continue
        var valid := true
        for other in occupied:
            if p.distance_to(other) < min_distance: valid = false; break
        if valid: return p
    return Vector2.INF
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

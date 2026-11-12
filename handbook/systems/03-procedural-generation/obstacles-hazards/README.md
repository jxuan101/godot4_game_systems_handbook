# System 08: Procedural Obstacles & Hazards

**Category:** Procedural Generation  
**Godot node focus:** `Node2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Populate valid positions with obstacles while preserving safe paths.

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

The complete example is [`project/scripts/examples/03-procedural-generation/obstacles-hazards.gd`](../../../../project/scripts/examples/03-procedural-generation/obstacles-hazards.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleObstaclesHazards
extends Node

func place_hazards(candidates: Array[Vector2], safe_points: Array[Vector2], min_clearance: float) -> Array[Vector2]:
    var result: Array[Vector2] = []
    for point in candidates:
        var safe := true
        for safe_point in safe_points:
            if point.distance_to(safe_point) < min_clearance: safe = false; break
        if safe: result.append(point)
    return result
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

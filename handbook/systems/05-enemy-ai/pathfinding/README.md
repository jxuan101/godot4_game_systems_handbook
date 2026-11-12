# System 05: Pathfinding & Navigation

**Category:** Enemy AI  
**Godot node focus:** `NavigationAgent2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Request paths and move toward the next navigation target.

## 2. Scene architecture

```text
NavigationAgent2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/05-enemy-ai/pathfinding.gd`](../../../../project/scripts/examples/05-enemy-ai/pathfinding.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePathfinding
extends Node

func find_path(map: AStarGrid2D, from_cell: Vector2i, to_cell: Vector2i) -> PackedVector2Array:
    if not map.is_in_boundsv(from_cell) or not map.is_in_boundsv(to_cell): return PackedVector2Array()
    if map.is_point_solid(from_cell) or map.is_point_solid(to_cell): return PackedVector2Array()
    return map.get_point_path(from_cell, to_cell)
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

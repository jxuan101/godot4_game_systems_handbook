# System 01: Random Room Generation

**Category:** Procedural Generation  
**Godot node focus:** `Node2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Place rooms from reusable scenes while preventing unwanted overlaps.

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

The complete example is [`project/scripts/examples/03-procedural-generation/random-room-generation.gd`](../../../../project/scripts/examples/03-procedural-generation/random-room-generation.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRandomRoomGeneration
extends Node

@export var min_size := Vector2i(5, 5)
@export var max_size := Vector2i(12, 10)
func make_room(rng: RandomNumberGenerator, bounds: Rect2i) -> Rect2i:
    var size := Vector2i(rng.randi_range(min_size.x, max_size.x), rng.randi_range(min_size.y, max_size.y))
    size.x = mini(size.x, bounds.size.x); size.y = mini(size.y, bounds.size.y)
    var pos := Vector2i(rng.randi_range(bounds.position.x, bounds.end.x-size.x), rng.randi_range(bounds.position.y, bounds.end.y-size.y))
    return Rect2i(pos, size)
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

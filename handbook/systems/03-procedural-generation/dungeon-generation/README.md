# System 02: Procedural Dungeon Generation

**Category:** Procedural Generation  
**Godot node focus:** `Node2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Generate a connected room graph and carve corridors between rooms.

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

The complete example is [`project/scripts/examples/03-procedural-generation/dungeon-generation.gd`](../../../../project/scripts/examples/03-procedural-generation/dungeon-generation.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDungeonGeneration
extends Node

@export var room_count := 12
@export var map_size := Vector2i(80, 60)
func generate(seed_value: int) -> Array[Rect2i]:
    var rng := RandomNumberGenerator.new(); rng.seed = seed_value
    var rooms: Array[Rect2i] = []
    for _i in range(room_count * 12):
        if rooms.size() >= room_count: break
        var size := Vector2i(rng.randi_range(6, 12), rng.randi_range(6, 10))
        var pos := Vector2i(rng.randi_range(1, map_size.x-size.x-1), rng.randi_range(1, map_size.y-size.y-1))
        var candidate := Rect2i(pos, size)
        var overlaps := false
        for room in rooms:
            if candidate.grow(1).intersects(room): overlaps = true; break
        if not overlaps: rooms.append(candidate)
    return rooms
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

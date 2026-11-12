# System 03: Procedural Cave Generation

**Category:** Procedural Generation  
**Godot node focus:** `TileMapLayer`  
**Status:** Working Godot 4 example

## 1. Purpose

Use cellular automata to create cave-like solid/empty regions.

## 2. Scene architecture

```text
TileMapLayer (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/03-procedural-generation/cave-generation.gd`](../../../../project/scripts/examples/03-procedural-generation/cave-generation.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleCaveGeneration
extends Node

@export var width := 64
@export var height := 40
@export_range(0.0, 1.0) var fill_chance := 0.46
func generate(seed_value: int, iterations := 4) -> Array:
    var rng := RandomNumberGenerator.new()
    rng.seed = seed_value
    var cells: Array = []
    for y in range(height):
        var row: Array = []
        for x in range(width): row.append(1 if rng.randf() < fill_chance else 0)
        cells.append(row)
    for _i in range(iterations):
        var next: Array = []
        for y in range(height):
            var row: Array = []
            for x in range(width):
                var walls := 0
                for oy in range(-1, 2):
                    for ox in range(-1, 2):
                        var nx := x + ox; var ny := y + oy
                        if nx < 0 or ny < 0 or nx >= width or ny >= height or cells[ny][nx] == 1: walls += 1
                row.append(1 if walls >= 5 else 0)
            next.append(row)
        cells = next
    return cells
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

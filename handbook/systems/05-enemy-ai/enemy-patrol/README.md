# System 03: Enemy Patrol Systems

**Category:** Enemy AI  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Move between patrol points and pause or reverse at endpoints.

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

The complete example is [`project/scripts/examples/05-enemy-ai/enemy-patrol.gd`](../../../../project/scripts/examples/05-enemy-ai/enemy-patrol.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEnemyPatrol
extends Node2D

@export var patrol_points: Array[Vector2] = []
@export var speed := 90.0
var target_index := 0
func _process(delta: float) -> void:
    if patrol_points.is_empty(): return
    var target := patrol_points[target_index]
    global_position = global_position.move_toward(target, speed * delta)
    if global_position.distance_to(target) < 2.0: target_index = (target_index + 1) % patrol_points.size()
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

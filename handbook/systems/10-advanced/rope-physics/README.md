# System 04: Grappling & Rope Physics

**Category:** Advanced Gameplay Systems  
**Godot node focus:** `Node2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Draw a rope between anchors and constrain its length with physics forces.

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

The complete example is [`project/scripts/examples/10-advanced/rope-physics.gd`](../../../../project/scripts/examples/10-advanced/rope-physics.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRopePhysics
extends Node2D

@export var segment_length := 18.0
@export var iterations := 8
var points: PackedVector2Array = []
var previous_points: PackedVector2Array = []
var anchor := Vector2.ZERO
func initialize(start: Vector2, end: Vector2, segments: int) -> void:
    points.clear(); previous_points.clear(); anchor = start
    var safe_segments := maxi(1, segments)
    segment_length = start.distance_to(end) / float(safe_segments)
    for i in range(safe_segments + 1):
        var point := start.lerp(end, float(i) / float(safe_segments))
        points.append(point); previous_points.append(point)
func simulate(delta: float, gravity := Vector2(0, 900)) -> void:
    if points.size() < 2 or delta <= 0.0: return
    for i in range(1, points.size()):
        var current := points[i]
        var velocity := current - previous_points[i]
        previous_points[i] = current
        points[i] = current + velocity + gravity * delta * delta
    for _j in range(iterations):
        points[0] = anchor
        for i in range(1, points.size()):
            var diff := points[i] - points[i-1]
            var distance := diff.length()
            if distance <= 0.001: continue
            var correction := diff.normalized() * (distance - segment_length)
            if i == 1: points[i] -= correction
            else:
                points[i] -= correction * 0.5
                points[i-1] += correction * 0.5
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

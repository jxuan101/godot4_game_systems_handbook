# System 01: Day & Night Cycle

**Category:** World & Environment  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Advance a normalized time-of-day value and emit phase changes.

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

The complete example is [`project/scripts/examples/06-world-environment/day-night.gd`](../../../../project/scripts/examples/06-world-environment/day-night.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDayNight
extends Node

signal time_changed(hour: float)
@export var seconds_per_day := 600.0
@export_range(0.0, 24.0) var starting_hour := 8.0
var elapsed := 0.0
var hour := 8.0
func _ready() -> void:
    hour = fposmod(starting_hour, 24.0)
    elapsed = hour / 24.0 * seconds_per_day
func _process(delta: float) -> void:
    elapsed = fposmod(elapsed + delta, seconds_per_day)
    hour = elapsed / seconds_per_day * 24.0
    time_changed.emit(hour)
func normalized_sun_height() -> float: return sin((hour / 24.0) * TAU - PI/2.0)
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

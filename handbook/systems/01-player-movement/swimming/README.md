# System 07: Swimming & Underwater Movement

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Switch between grounded and buoyant movement while inside water areas.

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

The complete example is [`project/scripts/examples/01-player-movement/swimming.gd`](../../../../project/scripts/examples/01-player-movement/swimming.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSwimming
extends CharacterBody2D

@export var swim_speed := 180.0
@export var water_gravity_scale := 0.25
var in_water := false
func set_in_water(value: bool) -> void: in_water = value
func _physics_process(delta: float) -> void:
    var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity.x = direction.x * swim_speed
    velocity.y = move_toward(velocity.y, direction.y * swim_speed, 600.0 * delta)
    if not in_water and not is_on_floor(): velocity.y += 1100.0 * delta
    elif in_water: velocity.y += 1100.0 * water_gravity_scale * delta
    move_and_slide()
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

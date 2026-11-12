# System 05: Vehicle Systems

**Category:** Advanced Gameplay Systems  
**Godot node focus:** `VehicleBody3D`  
**Status:** Working Godot 4 example

## 1. Purpose

Configure acceleration, steering, braking, and traction.

## 2. Scene architecture

```text
VehicleBody3D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/10-advanced/vehicles.gd`](../../../../project/scripts/examples/10-advanced/vehicles.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleVehicles
extends CharacterBody2D

@export var acceleration := 500.0
@export var max_speed := 420.0
@export var drag := 220.0
@export var turn_speed := 3.0
func _physics_process(delta: float) -> void:
    var throttle := Input.get_axis("move_back", "move_forward")
    var steering := Input.get_axis("move_left", "move_right")
    rotation += steering * turn_speed * delta * clampf(velocity.length() / max_speed, 0.2, 1.0)
    velocity += Vector2.UP.rotated(rotation) * throttle * acceleration * delta
    velocity = velocity.move_toward(Vector2.ZERO, drag * delta)
    if velocity.length() > max_speed: velocity = velocity.normalized() * max_speed
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

# System 05: Double Jump

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Track remaining jumps and reset the count on landing.

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

The complete example is [`project/scripts/examples/01-player-movement/double-jump.gd`](../../../../project/scripts/examples/01-player-movement/double-jump.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDoubleJump
extends CharacterBody2D

@export var jump_velocity := -420.0
@export var extra_jumps := 1
var jumps_left := 1
func _physics_process(delta: float) -> void:
    if is_on_floor(): jumps_left = extra_jumps
    if not is_on_floor(): velocity.y += 1100.0 * delta
    if Input.is_action_just_pressed("jump"):
        if is_on_floor(): velocity.y = jump_velocity
        elif jumps_left > 0:
            velocity.y = jump_velocity
            jumps_left -= 1
    velocity.x = Input.get_axis("move_left", "move_right") * 240.0
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

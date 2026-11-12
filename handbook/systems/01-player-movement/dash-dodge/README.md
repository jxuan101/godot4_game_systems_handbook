# System 04: Dash & Dodge

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

A timed movement burst with direction capture, cooldown, and interruption rules.

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

The complete example is [`project/scripts/examples/01-player-movement/dash-dodge.gd`](../../../../project/scripts/examples/01-player-movement/dash-dodge.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDashDodge
extends CharacterBody2D

@export var dash_speed := 720.0
@export var dash_duration := 0.16
@export var cooldown := 0.7
var dash_left := 0.0
var cooldown_left := 0.0
var dash_direction := Vector2.RIGHT
func _physics_process(delta: float) -> void:
    cooldown_left = maxf(0.0, cooldown_left - delta)
    if dash_left > 0.0:
        dash_left -= delta
        velocity = dash_direction * dash_speed
    else:
        var axis := Input.get_vector("move_left", "move_right", "move_up", "move_down")
        if Input.is_action_just_pressed("dash") and cooldown_left == 0.0:
            dash_direction = axis.normalized() if axis != Vector2.ZERO else Vector2.RIGHT
            dash_left = dash_duration
            cooldown_left = cooldown
        else: velocity = axis * 240.0
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

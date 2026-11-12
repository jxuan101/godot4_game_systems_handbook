# System 02: 3D Character Movement

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody3D`  
**Status:** Working Godot 4 example

## 1. Purpose

Camera-relative movement, acceleration, gravity, jumping, and sprinting.

## 2. Scene architecture

```text
CharacterBody3D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/01-player-movement/3d-character-movement.gd`](../../../../project/scripts/examples/01-player-movement/3d-character-movement.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody3D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name Example3DCharacterMovement
extends CharacterBody3D

@export var speed := 5.5
@export var acceleration := 18.0
@export var jump_velocity := 4.5
@export var gravity := 12.0
func _physics_process(delta: float) -> void:
    var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction := (transform.basis * Vector3(input.x, 0.0, input.y)).normalized()
    velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
    velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
    if not is_on_floor(): velocity.y -= gravity * delta
    elif Input.is_action_just_pressed("jump"): velocity.y = jump_velocity
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

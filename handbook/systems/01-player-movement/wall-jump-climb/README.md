# System 06: Wall Jump & Climb

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Detect walls, attach to climbable surfaces, and launch away from walls.

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

The complete example is [`project/scripts/examples/01-player-movement/wall-jump-climb.gd`](../../../../project/scripts/examples/01-player-movement/wall-jump-climb.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleWallJumpClimb
extends CharacterBody2D

@export var climb_speed := 120.0
@export var wall_jump := Vector2(300.0, -420.0)
func _physics_process(delta: float) -> void:
    if not is_on_floor(): velocity.y += 1100.0 * delta
    if is_on_wall() and Input.is_action_pressed("climb"):
        velocity.y = Input.get_axis("move_up", "move_down") * climb_speed
    if is_on_wall_only() and Input.is_action_just_pressed("jump"):
        velocity = Vector2(-get_wall_normal().x * wall_jump.x, wall_jump.y)
    velocity.x = Input.get_axis("move_left", "move_right") * 220.0
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

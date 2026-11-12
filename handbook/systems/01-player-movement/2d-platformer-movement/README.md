# System 01: 2D Platformer Movement

**Category:** Player Movement & Controllers  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Horizontal acceleration, friction, gravity, jumping, coyote time, and jump buffering.

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

The complete example is [`project/scripts/examples/01-player-movement/2d-platformer-movement.gd`](../../../../project/scripts/examples/01-player-movement/2d-platformer-movement.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `CharacterBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name Example2DPlatformerMovement
extends CharacterBody2D

@export var speed := 260.0
@export var acceleration := 1800.0
@export var friction := 2200.0
@export var jump_velocity := -420.0
@export var gravity := 1100.0
@export var coyote_time := 0.12
@export var jump_buffer := 0.12
var coyote_left := 0.0
var jump_left := 0.0
func _physics_process(delta: float) -> void:
    var axis := Input.get_axis("move_left", "move_right")
    velocity.x = move_toward(velocity.x, axis * speed, (acceleration if axis != 0.0 else friction) * delta)
    if is_on_floor(): coyote_left = coyote_time
    else:
        coyote_left = maxf(0.0, coyote_left - delta)
        velocity.y += gravity * delta
    if Input.is_action_just_pressed("jump"): jump_left = jump_buffer
    else: jump_left = maxf(0.0, jump_left - delta)
    if jump_left > 0.0 and coyote_left > 0.0:
        velocity.y = jump_velocity
        jump_left = 0.0
        coyote_left = 0.0
    if Input.is_action_just_released("jump") and velocity.y < 0.0: velocity.y *= 0.5
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

## Repository implementation note

The concrete component is `project/scripts/movement/platformer_movement.gd`. It exposes
`physics_step(delta, direction, jump_pressed)` and expects its parent to be a
`CharacterBody2D`. Call it from the parent's `_physics_process()` and call `move_and_slide()`
once afterward. The runnable demo uses `project/scripts/demo_player.gd` as a self-contained
example of the same movement concepts.

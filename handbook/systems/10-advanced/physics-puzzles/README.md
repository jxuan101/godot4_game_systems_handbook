# System 01: Physics-Based Puzzles

**Category:** Advanced Gameplay Systems  
**Godot node focus:** `RigidBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Build pushable objects, pressure plates, and physics-triggered puzzle logic.

## 2. Scene architecture

```text
RigidBody2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/10-advanced/physics-puzzles.gd`](../../../../project/scripts/examples/10-advanced/physics-puzzles.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `RigidBody2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePhysicsPuzzles
extends RigidBody2D

@export var required_mass := 5.0
@export var activation_delay := 0.2
signal puzzle_activated
var weighted_bodies: Array[RigidBody2D] = []
var activated := false
func _physics_process(_delta: float) -> void:
    var total := 0.0
    for body in weighted_bodies:
        if is_instance_valid(body): total += body.mass
    if not activated and total >= required_mass:
        activated = true
        get_tree().create_timer(activation_delay).timeout.connect(func(): puzzle_activated.emit())
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

# System 02: Ranged Combat & Projectiles

**Category:** Combat Systems  
**Godot node focus:** `Area2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Spawn projectiles with direction, speed, lifetime, and collision handling.

## 2. Scene architecture

```text
Area2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/02-combat/ranged-projectiles.gd`](../../../../project/scripts/examples/02-combat/ranged-projectiles.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Area2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRangedProjectiles
extends Area2D

@export var speed := 600.0
@export var damage := 12.0
@export var lifetime := 3.0
var direction := Vector2.RIGHT
func launch(from_position: Vector2, toward: Vector2) -> void:
    global_position = from_position
    direction = (toward - from_position).normalized()
    rotation = direction.angle()
func _ready() -> void:
    body_entered.connect(_on_body_entered)
    get_tree().create_timer(lifetime).timeout.connect(queue_free)
func _physics_process(delta: float) -> void: global_position += direction * speed * delta
func _on_body_entered(body: Node2D) -> void:
    if body.has_method("take_damage"): body.take_damage(damage)
    queue_free()
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

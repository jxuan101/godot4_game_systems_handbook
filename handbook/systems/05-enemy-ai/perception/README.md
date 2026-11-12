# System 04: Enemy Detection & Perception

**Category:** Enemy AI  
**Godot node focus:** `Area2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Detect targets by range and optionally validate line of sight.

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

The complete example is [`project/scripts/examples/05-enemy-ai/perception.gd`](../../../../project/scripts/examples/05-enemy-ai/perception.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Area2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePerception
extends Area2D

signal target_seen(target: Node2D)
signal target_lost(target: Node2D)
var visible_targets: Array[Node2D] = []
func _ready() -> void:
    body_entered.connect(_on_enter); body_exited.connect(_on_exit)
func _on_enter(body: Node2D) -> void:
    if body.is_in_group("player") and not visible_targets.has(body): visible_targets.append(body); target_seen.emit(body)
func _on_exit(body: Node2D) -> void:
    if visible_targets.has(body): visible_targets.erase(body); target_lost.emit(body)
func get_closest_target() -> Node2D:
    var best: Node2D = null
    for target in visible_targets:
        if not is_instance_valid(target): continue
        if best == null or global_position.distance_squared_to(target.global_position) < global_position.distance_squared_to(best.global_position): best = target
    return best
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

# System 03: Hitboxes & Hurtboxes

**Category:** Combat Systems  
**Godot node focus:** `Area2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Separate attack detection from damage reception.

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

The complete example is [`project/scripts/examples/02-combat/hitboxes-hurtboxes.gd`](../../../../project/scripts/examples/02-combat/hitboxes-hurtboxes.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Area2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHitboxesHurtboxes
extends Area2D

@export var damage := 10.0
@export var team_id := 0
var already_hit: Array[Node] = []
func _ready() -> void: area_entered.connect(_on_area_entered)
func _on_area_entered(area: Area2D) -> void:
    if area == self or already_hit.has(area): return
    var receiver := area.get_parent()
    if receiver == null or not receiver.has_method("take_damage"): return
    if receiver.get("team_id") == team_id: return
    already_hit.append(area)
    receiver.take_damage(damage)
func reset_hits() -> void: already_hit.clear()
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

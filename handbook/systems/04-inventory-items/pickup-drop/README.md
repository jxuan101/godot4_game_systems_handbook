# System 08: Item Pickup & Dropping

**Category:** Inventory & Item Systems  
**Godot node focus:** `Area2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Detect nearby item pickups and transfer item data into inventory.

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

The complete example is [`project/scripts/examples/04-inventory-items/pickup-drop.gd`](../../../../project/scripts/examples/04-inventory-items/pickup-drop.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Area2D` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExamplePickupDrop
extends Area2D

signal picked_up(item: Dictionary)
@export var item_data: Dictionary = {"id": "coin", "count": 1}
func _ready() -> void: body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
    if body.has_method("add_item") and body.add_item(item_data):
        picked_up.emit(item_data)
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

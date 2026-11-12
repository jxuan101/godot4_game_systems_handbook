# System 04: Drag-and-Drop Interfaces

**Category:** UI & Interaction  
**Godot node focus:** `Control`  
**Status:** Working Godot 4 example

## 1. Purpose

Transfer item data between UI slots using Godot drag-and-drop callbacks.

## 2. Scene architecture

```text
Control (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/09-ui-interaction/drag-drop.gd`](../../../../project/scripts/examples/09-ui-interaction/drag-drop.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Control` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDragDrop
extends Control

var dragged_data: Variant = null
func begin_drag(data: Variant) -> void: dragged_data = data
func can_drop() -> bool: return dragged_data != null
func _get_drag_data(_at_position: Vector2) -> Variant:
    return dragged_data
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    return data != null and has_method("receive_drop")
func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if has_method("receive_drop"):
        call("receive_drop", data)
        dragged_data = null
func accept_drop(target: Control) -> bool:
    if dragged_data == null or target == null or not target.has_method("receive_drop"): return false
    target.receive_drop(dragged_data)
    dragged_data = null
    return true
func cancel_drag() -> void: dragged_data = null
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

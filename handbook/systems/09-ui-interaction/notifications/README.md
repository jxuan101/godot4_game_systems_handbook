# System 06: Notification Systems

**Category:** UI & Interaction  
**Godot node focus:** `CanvasLayer`  
**Status:** Working Godot 4 example

## 1. Purpose

Queue short-lived messages and display them without overlap.

## 2. Scene architecture

```text
CanvasLayer (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/09-ui-interaction/notifications.gd`](../../../../project/scripts/examples/09-ui-interaction/notifications.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Control` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleNotifications
extends Control

@export var message_label: Label
var queue: Array[String] = []
var showing := false
func notify(message: String) -> void:
    queue.append(message)
    if not showing: _show_next()
func _show_next() -> void:
    if queue.is_empty(): showing = false; hide(); return
    showing = true; show()
    if message_label: message_label.text = queue.pop_front()
    await get_tree().create_timer(2.5).timeout
    _show_next()
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

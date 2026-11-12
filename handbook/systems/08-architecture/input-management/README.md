# System 07: Input Management

**Category:** Game Architecture & Infrastructure  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Centralize rebinding, input queries, and controller-friendly actions.

## 2. Scene architecture

```text
Node (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/08-architecture/input-management.gd`](../../../../project/scripts/examples/08-architecture/input-management.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleInputManagement
extends Node

func movement_vector() -> Vector2:
    return Input.get_vector("move_left", "move_right", "move_up", "move_down")
func consume_action(action: String) -> bool:
    return Input.is_action_just_pressed(action)
func remap_action(action: String, event: InputEvent) -> void:
    if not InputMap.has_action(action): InputMap.add_action(action)
    InputMap.action_erase_events(action)
    InputMap.action_add_event(action, event)
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

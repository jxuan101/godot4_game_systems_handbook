# System 02: Main Menu & Pause Menu

**Category:** UI & Interaction  
**Godot node focus:** `Control`  
**Status:** Working Godot 4 example

## 1. Purpose

Switch menu panels and pause the SceneTree safely.

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

The complete example is [`project/scripts/examples/09-ui-interaction/menus.gd`](../../../../project/scripts/examples/09-ui-interaction/menus.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Control` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleMenus
extends Control

@export var pause_menu: Control
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        get_viewport().set_input_as_handled()
        var paused := not get_tree().paused
        get_tree().paused = paused
        if pause_menu: pause_menu.visible = paused
func resume_game() -> void:
    get_tree().paused = false
    if pause_menu: pause_menu.hide()
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

# System 05: Dialogue Systems

**Category:** Progression & Gameplay Loops  
**Godot node focus:** `Resource`  
**Status:** Working Godot 4 example

## 1. Purpose

Represent dialogue nodes, choices, and branching conditions.

## 2. Scene architecture

```text
Resource (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/07-progression/dialogue.gd`](../../../../project/scripts/examples/07-progression/dialogue.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDialogue
extends Node

signal line_changed(speaker: String, text: String)
signal dialogue_finished
var lines: Array[Dictionary] = []
var index := -1
func start_dialogue(data: Array[Dictionary]) -> void:
    lines = data; index = -1; next_line()
func next_line() -> void:
    index += 1
    if index >= lines.size(): dialogue_finished.emit(); return
    var line := lines[index]
    line_changed.emit(str(line.get("speaker", "")), str(line.get("text", "")))
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

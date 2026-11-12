# System 03: Quest Systems

**Category:** Progression & Gameplay Loops  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Track objectives and quest states using event-driven progress.

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

The complete example is [`project/scripts/examples/07-progression/quests.gd`](../../../../project/scripts/examples/07-progression/quests.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleQuests
extends Node

signal quest_updated(id: String, state: String)
var quests: Dictionary = {}
func start_quest(id: String, objectives: Dictionary) -> void:
    quests[id] = {"objectives": objectives.duplicate(true), "complete": false}; quest_updated.emit(id, "started")
func add_progress(id: String, objective: String, amount := 1) -> void:
    if not quests.has(id): return
    var objectives: Dictionary = quests[id].objectives
    if not objectives.has(objective): return
    objectives[objective] = maxi(0, int(objectives[objective]) - amount)
    if objectives.values().all(func(v): return int(v) <= 0): quests[id].complete = true; quest_updated.emit(id, "completed")
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

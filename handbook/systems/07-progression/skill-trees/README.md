# System 02: Skill Trees

**Category:** Progression & Gameplay Loops  
**Godot node focus:** `Resource`  
**Status:** Working Godot 4 example

## 1. Purpose

Represent prerequisite nodes and validate unlock points.

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

The complete example is [`project/scripts/examples/07-progression/skill-trees.gd`](../../../../project/scripts/examples/07-progression/skill-trees.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleSkillTrees
extends Node

var unlocked: Dictionary = {}
func can_unlock(skill: Dictionary) -> bool:
    for prerequisite in skill.get("requires", []):
        if not unlocked.has(prerequisite): return false
    return true
func unlock(skill: Dictionary) -> bool:
    var id := str(skill.get("id", ""))
    if id.is_empty() or unlocked.has(id) or not can_unlock(skill): return false
    unlocked[id] = true
    return true
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

# System 07: Boss AI & Attack Patterns

**Category:** Enemy AI  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Sequence telegraphed phases and attacks using timers and state transitions.

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

The complete example is [`project/scripts/examples/05-enemy-ai/boss-ai.gd`](../../../../project/scripts/examples/05-enemy-ai/boss-ai.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleBossAi
extends Node

@export var phase_thresholds: Array[float] = [0.66, 0.33]
var phase := 0
func update_phase(health: float, maximum: float) -> int:
    if maximum <= 0.0: return phase
    var ratio := health / maximum
    while phase < phase_thresholds.size() and ratio <= phase_thresholds[phase]: phase += 1
    return phase
func choose_pattern(patterns: Array[String], rng: RandomNumberGenerator) -> String:
    return "" if patterns.is_empty() else patterns[rng.randi_range(0, patterns.size()-1)]
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

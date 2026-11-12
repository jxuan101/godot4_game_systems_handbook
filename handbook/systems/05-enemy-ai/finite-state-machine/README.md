# System 01: Finite State Machine AI

**Category:** Enemy AI  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Represent idle, patrol, chase, attack, and hurt states with explicit transitions.

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

The complete example is [`project/scripts/examples/05-enemy-ai/finite-state-machine.gd`](../../../../project/scripts/examples/05-enemy-ai/finite-state-machine.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleFiniteStateMachine
extends Node

signal state_changed(previous: String, current: String)
var current_state := "idle"
var states: Dictionary = {}
func add_state(id: String, callbacks: Dictionary) -> void: states[id] = callbacks
func change_state(next: String) -> void:
    if next == current_state or not states.has(next): return
    if states.has(current_state) and states[current_state].has("exit"): states[current_state].exit.call()
    var old := current_state; current_state = next
    if states[next].has("enter"): states[next].enter.call()
    state_changed.emit(old, next)
func update_state(delta: float) -> void:
    if states.has(current_state) and states[current_state].has("update"): states[current_state].update.call(delta)
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

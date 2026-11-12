# System 01: Melee Combat

**Category:** Combat Systems  
**Godot node focus:** `CharacterBody2D`  
**Status:** Working Godot 4 example

## 1. Purpose

Attack windows, hit detection, cooldowns, and attack state.

## 2. Scene architecture

```text
CharacterBody2D (root)
├── Visuals (optional)
├── CollisionShape / Area (when relevant)
└── Component nodes (only where responsibilities are separate)
```

Keep this system independent from unrelated gameplay concerns. The owning scene should
provide dependencies through exported NodePaths, explicit setup calls, or child references.

## 3. Working example

The complete example is [`project/scripts/examples/02-combat/melee-combat.gd`](../../../../project/scripts/examples/02-combat/melee-combat.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleMeleeCombat
extends Node

signal attack_started
signal attack_finished
@export var attack_cooldown := 0.35
@export var damage := 20.0
var ready_to_attack := true
func attack(targets: Array[Node]) -> bool:
    if not ready_to_attack: return false
    ready_to_attack = false
    attack_started.emit()
    for target in targets:
        if is_instance_valid(target) and target.has_method("take_damage"): target.take_damage(damage)
    get_tree().create_timer(attack_cooldown).timeout.connect(_reset_attack)
    return true
func _reset_attack() -> void:
    ready_to_attack = true
    attack_finished.emit()
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

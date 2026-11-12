# System 04: Object Pooling

**Category:** Game Architecture & Infrastructure  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Reuse frequently spawned nodes instead of repeatedly instantiating them.

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

The complete example is [`project/scripts/examples/08-architecture/object-pooling.gd`](../../../../project/scripts/examples/08-architecture/object-pooling.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleObjectPooling
extends Node

@export var packed_scene: PackedScene
@export var initial_size := 12
var available: Array[Node] = []
func _ready() -> void:
    for _i in range(initial_size): _create_one()
func _create_one() -> Node:
    if packed_scene == null: return null
    var item := packed_scene.instantiate(); add_child(item); item.set_process(false); item.hide(); available.append(item); return item
func acquire() -> Node:
    if available.is_empty(): _create_one()
    if available.is_empty(): return null
    var item: Node = available.pop_back(); item.show(); item.set_process(true); return item
func release(item: Node) -> void:
    if not is_instance_valid(item) or available.has(item): return
    item.set_process(false); item.hide(); available.append(item)
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

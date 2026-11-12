# System 07: Shops & Trading

**Category:** Inventory & Item Systems  
**Godot node focus:** `Node`  
**Status:** Working Godot 4 example

## 1. Purpose

Validate currency and stock before completing a purchase.

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

The complete example is [`project/scripts/examples/04-inventory-items/shops-trading.gd`](../../../../project/scripts/examples/04-inventory-items/shops-trading.gd). It implements the core behavior for this system rather than a placeholder lifecycle scaffold. Attach it to a `Node` node, configure its exported properties, and connect its signals where applicable. The script is intentionally small enough to read and extend.

```gdscript
# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleShopsTrading
extends Node

var stock: Dictionary = {}
func buy(item_id: String, price: int, wallet: Dictionary, inventory: Dictionary) -> bool:
    if int(wallet.get("coins", 0)) < price or int(stock.get(item_id, 0)) <= 0: return false
    wallet.coins = int(wallet.coins) - price
    inventory[item_id] = int(inventory.get(item_id, 0)) + 1
    stock[item_id] = int(stock[item_id]) - 1
    return true
func sell(item_id: String, price: int, wallet: Dictionary, inventory: Dictionary) -> bool:
    if int(inventory.get(item_id, 0)) <= 0: return false
    inventory[item_id] = int(inventory[item_id]) - 1
    wallet.coins = int(wallet.get("coins", 0)) + price
    stock[item_id] = int(stock.get(item_id, 0)) + 1
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

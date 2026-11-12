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

# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleCrafting
extends Node

func can_craft(inventory: Dictionary, recipe: Dictionary) -> bool:
    for id in recipe.get("ingredients", {}):
        if int(inventory.get(id, 0)) < int(recipe.ingredients[id]): return false
    return true
func craft(inventory: Dictionary, recipe: Dictionary) -> bool:
    if not can_craft(inventory, recipe): return false
    for id in recipe.ingredients: inventory[id] = int(inventory.get(id, 0)) - int(recipe.ingredients[id])
    var output: Dictionary = recipe.get("output", {})
    var out_id := str(output.get("id", ""))
    inventory[out_id] = int(inventory.get(out_id, 0)) + int(output.get("count", 1))
    return true

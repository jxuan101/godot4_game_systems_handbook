# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleLootTables
extends Node

func roll_table(table: Array[Dictionary], rolls: int, rng: RandomNumberGenerator) -> Array:
    var results: Array = []
    for _i in range(rolls):
        var total := 0.0
        for entry in table: total += maxf(0.0, float(entry.get("weight", 0.0)))
        if total <= 0.0: break
        var r := rng.randf() * total
        for entry in table:
            r -= maxf(0.0, float(entry.get("weight", 0.0)))
            if r <= 0.0: results.append(entry.get("item")); break
    return results

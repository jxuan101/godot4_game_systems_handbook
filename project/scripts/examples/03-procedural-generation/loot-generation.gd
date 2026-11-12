# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleLootGeneration
extends Node

func choose_weighted(entries: Array[Dictionary], rng: RandomNumberGenerator) -> Variant:
    var total := 0.0
    for entry in entries: total += maxf(0.0, float(entry.get("weight", 0.0)))
    if total <= 0.0: return null
    var roll := rng.randf() * total
    for entry in entries:
        roll -= maxf(0.0, float(entry.get("weight", 0.0)))
        if roll <= 0.0: return entry.get("item")
    return entries.back().get("item")

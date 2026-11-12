# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleItemRarity
extends Node

const MULTIPLIERS := {"common": 1.0, "uncommon": 1.2, "rare": 1.5, "epic": 2.0, "legendary": 3.0}
func roll_rarity(rng: RandomNumberGenerator) -> String:
    var roll := rng.randf()
    if roll < 0.01: return "legendary"
    if roll < 0.06: return "epic"
    if roll < 0.20: return "rare"
    if roll < 0.45: return "uncommon"
    return "common"
func scale_stat(base_value: float, rarity: String) -> float: return base_value * float(MULTIPLIERS.get(rarity, 1.0))

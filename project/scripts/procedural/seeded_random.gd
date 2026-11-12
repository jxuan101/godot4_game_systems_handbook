class_name SeededRandom
extends RefCounted

var rng := RandomNumberGenerator.new()

func set_seed(value: int) -> void:
    rng.seed = value

func choose_weighted(entries: Array[Dictionary]) -> Variant:
    var total := 0.0
    for entry in entries:
        total += maxf(0.0, float(entry.get("weight", 0.0)))
    if total <= 0.0:
        return null
    var roll := rng.randf_range(0.0, total)
    for entry in entries:
        roll -= maxf(0.0, float(entry.get("weight", 0.0)))
        if roll <= 0.0:
            return entry.get("value")
    return entries.back().get("value")

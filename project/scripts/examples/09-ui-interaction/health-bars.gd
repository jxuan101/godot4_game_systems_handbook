# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHealthBars
extends ProgressBar

@export var smoothing := 8.0
var target_value := 100.0
func set_health(current: float, maximum: float) -> void:
    max_value = maxf(1.0, maximum)
    target_value = clampf(current, 0.0, max_value)
func _process(delta: float) -> void:
    value = move_toward(value, target_value, smoothing * max_value * delta)

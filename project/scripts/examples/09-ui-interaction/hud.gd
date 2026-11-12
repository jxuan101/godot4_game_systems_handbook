# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleHud
extends CanvasLayer

@export var health_label: Label
@export var score_label: Label
func set_health(current: float, maximum: float) -> void:
    if health_label: health_label.text = "HP %d / %d" % [roundi(current), roundi(maximum)]
func set_score(score: int) -> void:
    if score_label: score_label.text = "Score: %d" % score

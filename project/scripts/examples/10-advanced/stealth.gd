# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleStealth
extends Node

@export var visibility_radius := 240.0
@export var crouch_multiplier := 0.45
func visibility_score(observer: Vector2, target: Vector2, is_crouching: bool, light_factor := 1.0) -> float:
    var distance_factor := clampf(1.0 - observer.distance_to(target) / visibility_radius, 0.0, 1.0)
    return distance_factor * (crouch_multiplier if is_crouching else 1.0) * clampf(light_factor, 0.0, 1.0)
func is_detected(score: float, threshold := 0.35) -> bool: return score >= threshold

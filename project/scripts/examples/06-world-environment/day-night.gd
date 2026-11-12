# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleDayNight
extends Node

signal time_changed(hour: float)
@export var seconds_per_day := 600.0
@export_range(0.0, 24.0) var starting_hour := 8.0
var elapsed := 0.0
var hour := 8.0
func _ready() -> void:
    hour = fposmod(starting_hour, 24.0)
    elapsed = hour / 24.0 * seconds_per_day
func _process(delta: float) -> void:
    elapsed = fposmod(elapsed + delta, seconds_per_day)
    hour = elapsed / seconds_per_day * 24.0
    time_changed.emit(hour)
func normalized_sun_height() -> float: return sin((hour / 24.0) * TAU - PI/2.0)

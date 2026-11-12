# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleWeather
extends Node

signal weather_changed(weather: String)
@export var weather_types: Array[String] = ["clear", "rain", "storm", "fog"]
var current_weather := "clear"
func roll_weather(rng: RandomNumberGenerator) -> String:
    if weather_types.is_empty(): return current_weather
    current_weather = weather_types[rng.randi_range(0, weather_types.size()-1)]
    weather_changed.emit(current_weather)
    return current_weather

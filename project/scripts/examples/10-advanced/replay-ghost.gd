# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleReplayGhost
extends Node

@export var sample_interval := 0.05
var recording: Array[Dictionary] = []
var accumulator := 0.0
func record_position(position: Vector2, facing := 1.0) -> void:
    accumulator += get_process_delta_time()
    if accumulator < sample_interval: return
    accumulator = 0.0
    recording.append({"position": position, "facing": facing, "time": Time.get_ticks_msec()})
func clear_recording() -> void: recording.clear()
func get_frame(index: int) -> Dictionary: return recording[index] if index >= 0 and index < recording.size() else {}

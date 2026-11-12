# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleFiniteStateMachine
extends Node

signal state_changed(previous: String, current: String)
var current_state := "idle"
var states: Dictionary = {}
func add_state(id: String, callbacks: Dictionary) -> void: states[id] = callbacks
func change_state(next: String) -> void:
    if next == current_state or not states.has(next): return
    if states.has(current_state) and states[current_state].has("exit"): states[current_state].exit.call()
    var old := current_state; current_state = next
    if states[next].has("enter"): states[next].enter.call()
    state_changed.emit(old, next)
func update_state(delta: float) -> void:
    if states.has(current_state) and states[current_state].has("update"): states[current_state].update.call(delta)

class_name SimpleStateMachine
extends Node

signal state_changed(previous: StringName, current: StringName)
@export var initial_state: StringName
var current_state: StringName

func _ready() -> void:
    current_state = initial_state

func transition_to(next_state: StringName) -> void:
    if next_state == current_state:
        return
    var previous := current_state
    current_state = next_state
    state_changed.emit(previous, current_state)

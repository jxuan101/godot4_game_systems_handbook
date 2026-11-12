# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleEventBus
extends Node

var subscribers: Dictionary = {}
func publish(event_name: String, payload: Dictionary = {}) -> void:
    if event_name.is_empty(): return
    for callback in subscribers.get(event_name, []).duplicate():
        if callback.is_valid(): callback.call(payload)
func subscribe_to(event_name: String, callback: Callable) -> void:
    if event_name.is_empty() or not callback.is_valid(): return
    var listeners: Array = subscribers.get(event_name, [])
    if not listeners.has(callback): listeners.append(callback)
    subscribers[event_name] = listeners
func unsubscribe(event_name: String, callback: Callable) -> void:
    if not subscribers.has(event_name): return
    var listeners: Array = subscribers[event_name]
    listeners.erase(callback)
    if listeners.is_empty(): subscribers.erase(event_name)
    else: subscribers[event_name] = listeners

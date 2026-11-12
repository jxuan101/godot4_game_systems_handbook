# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleBehaviorTrees
extends Node

enum Status { SUCCESS, FAILURE, RUNNING }
func sequence(children: Array[Callable]) -> int:
    for child in children:
        var result: int = child.call()
        if result != Status.SUCCESS: return result
    return Status.SUCCESS
func selector(children: Array[Callable]) -> int:
    for child in children:
        var result: int = child.call()
        if result != Status.FAILURE: return result
    return Status.FAILURE

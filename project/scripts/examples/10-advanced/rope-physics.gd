# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleRopePhysics
extends Node2D

@export var segment_length := 18.0
@export var iterations := 8
var points: PackedVector2Array = []
var previous_points: PackedVector2Array = []
var anchor := Vector2.ZERO
func initialize(start: Vector2, end: Vector2, segments: int) -> void:
    points.clear(); previous_points.clear(); anchor = start
    var safe_segments := maxi(1, segments)
    segment_length = start.distance_to(end) / float(safe_segments)
    for i in range(safe_segments + 1):
        var point := start.lerp(end, float(i) / float(safe_segments))
        points.append(point); previous_points.append(point)
func simulate(delta: float, gravity := Vector2(0, 900)) -> void:
    if points.size() < 2 or delta <= 0.0: return
    for i in range(1, points.size()):
        var current := points[i]
        var velocity := current - previous_points[i]
        previous_points[i] = current
        points[i] = current + velocity + gravity * delta * delta
    for _j in range(iterations):
        points[0] = anchor
        for i in range(1, points.size()):
            var diff := points[i] - points[i-1]
            var distance := diff.length()
            if distance <= 0.001: continue
            var correction := diff.normalized() * (distance - segment_length)
            if i == 1: points[i] -= correction
            else:
                points[i] -= correction * 0.5
                points[i-1] += correction * 0.5

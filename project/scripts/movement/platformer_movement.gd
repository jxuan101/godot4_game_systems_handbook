class_name PlatformerMovement
extends Node

@export var speed := 220.0
@export var acceleration := 1200.0
@export var friction := 1400.0
@export_range(0.0, 1.0) var air_control := 0.8
@export var jump_velocity := -400.0
@export var coyote_time := 0.12
@export var jump_buffer_time := 0.12

var body: CharacterBody2D
var gravity := float(ProjectSettings.get_setting("physics/2d/default_gravity"))
var _coyote_left := 0.0
var _jump_buffer_left := 0.0

func _ready() -> void:
    body = get_parent() as CharacterBody2D
    assert(body != null, "PlatformerMovement must be child of CharacterBody2D")

func physics_step(delta: float, direction: float, jump_pressed: bool) -> void:
    if body.is_on_floor():
        _coyote_left = coyote_time
    else:
        _coyote_left = maxf(0.0, _coyote_left - delta)
        body.velocity.y += gravity * delta

    _jump_buffer_left = jump_buffer_time if jump_pressed else maxf(0.0, _jump_buffer_left - delta)

    var rate := acceleration if not is_zero_approx(direction) else friction
    if not body.is_on_floor():
        rate *= air_control
    body.velocity.x = move_toward(body.velocity.x, direction * speed, rate * delta)

    if _jump_buffer_left > 0.0 and _coyote_left > 0.0:
        body.velocity.y = jump_velocity
        _jump_buffer_left = 0.0
        _coyote_left = 0.0

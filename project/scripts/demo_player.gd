extends CharacterBody2D

@export var move_speed := 220.0
@export var acceleration := 1200.0
@export var friction := 1400.0
@export var jump_velocity := -400.0
@export var coyote_time := 0.12
@export var jump_buffer_time := 0.12

var gravity := float(ProjectSettings.get_setting("physics/2d/default_gravity"))
var _coyote_left := 0.0
var _jump_buffer_left := 0.0

func _physics_process(delta: float) -> void:
    var direction := Input.get_axis("move_left", "move_right")
    var rate := acceleration if not is_zero_approx(direction) else friction
    velocity.x = move_toward(velocity.x, direction * move_speed, rate * delta)

    if is_on_floor():
        _coyote_left = coyote_time
    else:
        _coyote_left = maxf(0.0, _coyote_left - delta)
        velocity.y += gravity * delta

    if Input.is_action_just_pressed("jump"):
        _jump_buffer_left = jump_buffer_time
    else:
        _jump_buffer_left = maxf(0.0, _jump_buffer_left - delta)

    if _jump_buffer_left > 0.0 and _coyote_left > 0.0:
        velocity.y = jump_velocity
        _jump_buffer_left = 0.0
        _coyote_left = 0.0

    move_and_slide()

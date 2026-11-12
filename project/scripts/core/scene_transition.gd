class_name SceneTransition
extends CanvasLayer

@export var fade_seconds := 0.25
@onready var color_rect: ColorRect = $ColorRect
var _busy := false

func change_scene(path: String) -> void:
    if _busy:
        return
    _busy = true
    var tween := create_tween()
    tween.tween_property(color_rect, "color:a", 1.0, fade_seconds)
    await tween.finished
    var error := get_tree().change_scene_to_file(path)
    if error != OK:
        push_error("Could not change scene: %s" % path)
        _busy = false
        return
    color_rect.color.a = 1.0
    var fade_in := create_tween()
    fade_in.tween_property(color_rect, "color:a", 0.0, fade_seconds)
    await fade_in.finished
    _busy = false

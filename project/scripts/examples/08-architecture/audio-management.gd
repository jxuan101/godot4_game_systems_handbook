# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleAudioManagement
extends Node

@export var music_player: AudioStreamPlayer
@export var sfx_player: AudioStreamPlayer
func play_music(stream: AudioStream, fade_seconds := 0.4) -> void:
    if music_player == null: return
    music_player.stream = stream; music_player.volume_db = -30.0; music_player.play()
    var tween := create_tween(); tween.tween_property(music_player, "volume_db", 0.0, fade_seconds)
func play_sfx(stream: AudioStream) -> void:
    if sfx_player == null: return
    sfx_player.stream = stream; sfx_player.play()

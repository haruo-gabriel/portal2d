extends Node

class_name AudioManager

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
var fade_duration: float
var elapsed_time: float
var audio_player: AudioStreamPlayer
var music_bus_volume: int

func fade_in(audio_player_to_fade: AudioStreamPlayer, duration: float) -> void:
	audio_player = audio_player_to_fade
	audio_player.volume_db = -80
	music_bus_volume = AudioServer.get_bus_volume_db(MUSIC_BUS_ID)
	audio_player.play()
	fade_duration = duration
	elapsed_time = 0
	set_process(true)

func _process(delta: float) -> void:
	elapsed_time += delta
	var t = clamp(elapsed_time / fade_duration, 0, 1)
	audio_player.volume_db = lerp(-80, music_bus_volume, t)
	if t >= 1:
		set_process(false)
		print("Fade in complete, volume set to 0db")

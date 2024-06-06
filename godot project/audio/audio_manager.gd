extends Node

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
const MIN_VOLUME: int = -80

func _ready():
	#var instance = create_instance($AudioStreamPlayer)
	#
	#fade_in(instance, 1.0)
	#
	#$Timer.start()
	#await $Timer.timeout
	#print("Timeout")
	#
	#fade_out(instance, 1.0)
	pass
	
func create_instance(audio_stream: AudioStreamPlayer) -> AudioStreamPlayer:
	var instance = AudioStreamPlayer.new()
	instance = audio_stream
	return instance

func fade_in(audio_stream: AudioStreamPlayer, duration: float, autoplay: bool):
	print("Fading in.")
	# duration is in seconds
	var tween: Tween = create_tween()
	var max_volume = audio_stream.volume_db
	audio_stream.volume_db = -80
	audio_stream.autoplay = autoplay
	audio_stream.playing = true
	tween.tween_property(audio_stream, "volume_db", max_volume, duration)
	
	
func fade_out(audio_stream: AudioStreamPlayer, duration: float):
	print("Fading out.")
	# duration is in seconds
	var tween: Tween = create_tween()
	tween.tween_property(audio_stream, "volume_db", -80, duration)
	await tween.finished
	audio_stream.playing = false

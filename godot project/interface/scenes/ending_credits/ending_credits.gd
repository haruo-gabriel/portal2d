extends Control

@onready var main_menu_music = $MainMenuMusic
var audio_manager = null

func _ready() -> void:
	var AudioManager = preload("res://audio.gd")
	audio_manager = AudioManager.new()
	add_child(audio_manager)
	audio_manager.fade_in(main_menu_music, 4.0)

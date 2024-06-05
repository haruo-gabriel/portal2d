extends Control

@onready var main_menu_music = $MainMenuMusic
var audio_manager = null

func _ready() -> void:
	var AudioManager = preload("res://audio.gd")
	audio_manager = AudioManager.new()
	add_child(audio_manager)
	audio_manager.fade_in(main_menu_music, 4.0)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://interface/scenes/main_menu/main_menu.tscn")

extends Control

#@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
#@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@export var new_game_scene: PackedScene
@export var credits_scene: PackedScene
@onready var main_menu_music = $MainMenuMusic
var audio_manager = null

func _ready() -> void:
	var AudioManager = preload("res://audio.gd")
	audio_manager = AudioManager.new()
	add_child(audio_manager)
	audio_manager.fade_in(main_menu_music, 4.0)


func _on_new_game_button_pressed():
	$ScreenTransition.transition(new_game_scene)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	$ScreenTransition.transition(credits_scene)

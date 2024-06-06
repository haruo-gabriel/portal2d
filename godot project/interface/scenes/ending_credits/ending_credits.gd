extends Control

@onready var main_menu_music = $MainMenuMusic
@export var target_scene: PackedScene 

func _ready() -> void:
	AudioManager.fade_in($MainMenuMusic, 1.0, true)

func _on_main_menu_button_pressed():
	await AudioManager.fade_out($MainMenuMusic, 2.0)
	get_tree().change_scene_to_packed(target_scene)

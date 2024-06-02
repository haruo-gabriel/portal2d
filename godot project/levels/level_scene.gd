extends Node2D

@onready var level_music = $LevelMusic
var audio_manager = null

func _ready() -> void:
	var AudioManager = preload("res://audio.gd")
	audio_manager = AudioManager.new()
	add_child(audio_manager)
	audio_manager.fade_in(level_music, 1.0)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		%HUD.visible = false
		%Pause.visible = true
		get_tree().paused = true

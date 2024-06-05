extends Node2D

@onready var level_music = $LevelMusic

@onready var hud: Control = $CanvasLayer/HUD
@onready var pause: Control = $CanvasLayer/Pause

var audio_manager = null

func _ready() -> void:
	var AudioManager = preload("res://audio.gd")
	audio_manager = AudioManager.new()
	add_child(audio_manager)
	audio_manager.fade_in(level_music, 1.0)

func _process(_delta: float) -> void:
	
	hud.visible = not pause.visible

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_cancel"):
		hud.visible = false
		pause.visible = true
		get_tree().paused = true

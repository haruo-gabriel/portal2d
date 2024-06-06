extends Node2D

@export var level_music: AudioStreamPlayer
@export var hud: CanvasLayer
@export var pause: Control

var audio_manager = null

func _ready() -> void:
	Portals.clear()

func _process(_delta: float) -> void:
	
	hud.visible = not pause.visible

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_cancel"):
		hud.visible = false
		pause.visible = true
		get_tree().paused = true

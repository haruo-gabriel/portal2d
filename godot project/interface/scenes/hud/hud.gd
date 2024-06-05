
extends Control

@export var player: Player

func _ready() -> void:
	$ProgressBar.player = player

func _process(delta: float) -> void:
	pass

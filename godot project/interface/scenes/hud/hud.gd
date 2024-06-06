
extends CanvasLayer

@export var player: Player

func _ready() -> void:
	$ProgressBar.player = player

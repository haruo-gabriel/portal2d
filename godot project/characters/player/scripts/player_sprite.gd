
extends Sprite2D

@export var player: Player

func _process(_delta: float) -> void:
	
	if player.direction:
		flip_h = player.direction < 0
	

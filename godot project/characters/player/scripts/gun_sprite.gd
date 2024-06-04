
extends Sprite2D

@export var player: Player

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	if player.direction:
		flip_h = player.direction < 0
	
	rotation = player.angle + PI * (1 if flip_h else 0)

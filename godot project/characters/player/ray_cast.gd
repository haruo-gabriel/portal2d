
extends RayCast2D

@export var player: Player

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	target_position = 1000 * Vector2(cos(player.angle), sin(player.angle))

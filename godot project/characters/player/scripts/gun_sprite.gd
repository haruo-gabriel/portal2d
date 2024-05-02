
extends Sprite2D

@export var player: Player

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	rotation = player.angle

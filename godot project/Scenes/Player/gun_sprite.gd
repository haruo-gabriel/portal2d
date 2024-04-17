
extends Sprite2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	rotation = player_stats.angle

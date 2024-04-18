
extends RayCast2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	target_position = 1000 * Vector2(cos(player_stats.angle), sin(player_stats.angle))

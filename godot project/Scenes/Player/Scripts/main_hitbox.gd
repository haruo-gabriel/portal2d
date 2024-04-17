
extends CollisionShape2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	disabled = false

func _process(_delta: float) -> void:
	disabled = player_stats.is_crouching

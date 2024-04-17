
extends Sprite2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:

	if player_stats.direction:
		flip_h = player_stats.direction > 0

	if player_stats.is_crouching: show()
	else: hide()
	

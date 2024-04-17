
extends Sprite2D

@onready var stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if stats.direction:
		flip_h = stats.direction < 0

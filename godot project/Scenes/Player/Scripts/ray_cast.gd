
extends RayCast2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass

func _draw():

	draw_circle(global_position, 100, Color.RED)

func _process(_delta: float) -> void:

	print(is_colliding())

	target_position = Vector2(-100, 0)

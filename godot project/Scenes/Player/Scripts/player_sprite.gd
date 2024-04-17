
extends Sprite2D

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

@export var crouched_offset: Vector2 = Vector2(0, 50)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	if player_stats.direction:
		flip_h = player_stats.direction < 0
	
	offset = crouched_offset if player_stats.is_crouching else Vector2.ZERO

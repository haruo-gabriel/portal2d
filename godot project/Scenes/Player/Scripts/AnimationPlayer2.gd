
extends AnimationPlayer

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	if player_stats.velocity.x and player_stats.is_on_floor: play("Walk (Crouched)")
	else: play("Idle (Crouched)")


class_name Walking
extends State

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

func enter() -> void:
	animation.play("Walk")

func physics_process(delta: float) -> void:
	
	if player_stats.direction:

		var step = constants.HORIZONTAL_ACCELERATION
		var new_speed = player_stats.direction * constants.WALKING_SPEED
		
		player.velocity.x = move_toward(player.velocity.x, new_speed, step)

	else:
		player.velocity.x = move_toward(player.velocity.x, 0, constants.GROUND_DRAG)

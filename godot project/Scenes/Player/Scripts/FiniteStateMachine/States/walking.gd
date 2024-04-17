
class_name Walking
extends State

@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

func enter() -> void:
	animation.play("Walk")

func physics_update(delta: float) -> void:
	super(delta)

	if player_stats.direction:

		var step = constants.HORIZONTAL_ACCELERATION
		var new_speed = player_stats.direction * constants.WALKING_SPEED
		
		player_stats.velocity.x = move_toward(player_stats.velocity.x, new_speed, step)

	else:
		player_stats.velocity.x = move_toward(player_stats.velocity.x, 0, constants.GROUND_DRAG)

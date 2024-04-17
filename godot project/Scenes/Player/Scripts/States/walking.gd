
class_name Walking
extends PlayerState

func enter() -> void:
	animation.play("Walk")

func physics_update(delta: float) -> void:
	
	super(delta)

	if player_stats.direction:

		var step = constants.HORIZONTAL_ACCELERATION
		var new_speed = player_stats.direction * constants.WALKING_SPEED
		
		if player_stats.is_crouching:
			new_speed *= constants.CROUCH_SPEED_MULTIPLIER
		
		player_stats.velocity.x = move_toward(player_stats.velocity.x, new_speed, step)

	else:
		player_stats.velocity.x = move_toward(player_stats.velocity.x, 0, constants.GROUND_DRAG)


class_name Walking
extends PlayerState

func enter() -> void:
	animation.play("Walk")
	player.velocity += Vector2(.001, 0)

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return

	if not player.is_on_floor():
		player.velocity.y += delta * game_constants.GRAVITY

	if player.direction:

		var step = constants.HORIZONTAL_ACCELERATION
		var new_speed = player.direction * constants.WALKING_SPEED
		
		if player.is_crouching:
			new_speed *= constants.CROUCH_SPEED_MULTIPLIER
		
		player.velocity.x = move_toward(player.velocity.x, new_speed, step)

	else:
		player.velocity.x = move_toward(player.velocity.x, 0, constants.GROUND_DRAG)

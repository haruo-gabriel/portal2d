
class_name Falling
extends PlayerState

func enter() -> void:
	
	player.is_falling = true
	
	animation.play("Fall")

func exit() -> void:
	
	player.is_falling = false

func physics_update(delta: float) -> void:

	if try_basic_change():
		return
	
	player.velocity.y += game_constants.GRAVITY * delta

	var step: float = player_constants.HORIZONTAL_ACCELERATION * player_constants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * player_constants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)


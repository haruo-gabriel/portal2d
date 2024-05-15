
class_name PlayerInAir
extends PlayerState


func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return
	
	player.velocity.y += delta * GameConstants.GRAVITY
	
	var step: float = PlayerConstants.HORIZONTAL_ACCELERATION * PlayerConstants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * PlayerConstants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	if not player.direction:
		new_speed = move_toward(player.velocity.x, 0, PlayerConstants.IN_AIR_DRAG)

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)

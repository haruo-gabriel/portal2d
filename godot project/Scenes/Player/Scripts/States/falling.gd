
class_name Falling
extends PlayerState

func enter() -> void:
	
	player_stats.is_falling = true
	
	animation.play("Fall")

func exit() -> void:
	
	player_stats.is_falling = false

func physics_update(delta: float) -> void:

	var new_state: String = check_basic_change()
	
	if new_state != "" and new_state != "falling":
		transitioned.emit(self, new_state)
		return
	
	player_stats.velocity.y += gravity * delta

	var step: float = constants.HORIZONTAL_ACCELERATION * constants.IN_AIR_MULTIPLIER
	var new_speed: float = player_stats.direction * constants.WALKING_SPEED

	if sign(player_stats.velocity.x) == sign(player_stats.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player_stats.velocity.x))

	player_stats.velocity.x = move_toward(player_stats.velocity.x, new_speed, step)


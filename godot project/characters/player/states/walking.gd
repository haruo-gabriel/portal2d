
class_name Walking
extends PlayerState

func _ready() -> void:
	animation_name = "Walk"

func enter() -> void:

	player.velocity += player.direction * Vector2(.001, 0)

	animation.try_play(animation_name)

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return

	if not player.is_on_floor():
		player.velocity.y += delta * GameConstants.GRAVITY

	if player.direction:

		var step = PlayerConstants.HORIZONTAL_ACCELERATION
		var new_speed = player.direction * PlayerConstants.WALKING_SPEED
		
		if player.is_crouching:
			new_speed *= PlayerConstants.CROUCH_SPEED_MULTIPLIER
		
		player.velocity.x = move_toward(player.velocity.x, new_speed, step)

	else:
		player.velocity.x = move_toward(player.velocity.x, 0, PlayerConstants.GROUND_DRAG)

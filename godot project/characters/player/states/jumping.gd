
class_name Jumping
extends PlayerState

func enter() -> void:

	player.velocity.y = constants.JUMP_VELOCITY
	player.velocity.x *= constants.BHOP_MULTIPLIER

	player.is_on_floor = false

	player.position = player.position
	player.velocity = player.velocity

	player.move_and_slide()
	
	player.position = player.position
	player.velocity = player.velocity

	animation.play("Jump")

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return
	
	if not player_stats.is_on_floor:
		player_stats.velocity.y += delta * game_constants.GRAVITY
	
	var step: float = constants.HORIZONTAL_ACCELERATION * constants.IN_AIR_MULTIPLIER
	var new_speed: float = player_stats.direction * constants.WALKING_SPEED

	if sign(player_stats.velocity.x) == sign(player_stats.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player_stats.velocity.x))

	player_stats.velocity.x = move_toward(player_stats.velocity.x, new_speed, step)


func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass


class_name Jumping
extends PlayerState

func enter() -> void:

	player.velocity.y = player_constants.JUMP_VELOCITY
	player.velocity.x *= player_constants.BHOP_MULTIPLIER

	player.move_and_slide()

	animation.play("Jump")

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return
	
	if not player.is_on_floor():
		player.velocity.y += delta * game_constants.GRAVITY
	
	var step: float = player_constants.HORIZONTAL_ACCELERATION * player_constants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * player_constants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)


func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass


class_name Jumping
extends PlayerState

func enter() -> void:

	player.velocity.y = PlayerConstants.JUMP_VELOCITY
	player.velocity.x *= PlayerConstants.BHOP_MULTIPLIER

	player.move_and_slide()

	animation.play("Jump")

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return
	
	if not player.is_on_floor():
		player.velocity.y += delta * GameConstants.GRAVITY
	
	var step: float = PlayerConstants.HORIZONTAL_ACCELERATION * PlayerConstants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * PlayerConstants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)


func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass

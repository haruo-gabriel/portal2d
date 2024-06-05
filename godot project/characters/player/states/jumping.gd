
class_name PlayerJumping
extends PlayerInAir

#@onready var jump_sfx = $JumpingSFX

func _ready() -> void:
	animation_name = "Jump"

func enter() -> void:

	player.velocity.y = PlayerConstants.JUMP_VELOCITY
	player.velocity.x *= PlayerConstants.BHOP_MULTIPLIER

	player.move_and_slide()

	animation.try_play(animation_name)
	
	#jump_sfx.play()

func physics_update(delta: float) -> void:
	
	if try_basic_change():
		return
	
	player.velocity.y += delta * GameConstants.GRAVITY
	
	if not player.direction:
		player.velocity.x = move_toward(player.velocity.x, 0, PlayerConstants.IN_AIR_DRAG)
		return
	
	var step: float = PlayerConstants.HORIZONTAL_ACCELERATION * PlayerConstants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * PlayerConstants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)

func _process(_delta: float) -> void:
	pass

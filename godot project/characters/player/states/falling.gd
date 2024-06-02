
class_name PlayerFalling
extends PlayerInAir

# SFX resources
@onready var landing_on_grass_sfx = $"../../LandingOnGrassSFX"
@onready var landing_on_rock_sfx = $"../../LandingOnRockSFX"


func _ready() -> void:
	animation_name = "Fall"

func enter() -> void:
	
	player.is_falling = true
	
	animation.try_play(animation_name)

func exit() -> void:
	landing_on_grass_sfx.play()
	
	player.is_falling = false

func physics_update(delta: float) -> void:

	if try_basic_change():
		return
	
	player.velocity.y += GameConstants.GRAVITY * delta

	if not player.direction:
		return

	var step: float = PlayerConstants.HORIZONTAL_ACCELERATION * PlayerConstants.IN_AIR_MULTIPLIER
	var new_speed: float = player.direction * PlayerConstants.WALKING_SPEED

	if sign(player.velocity.x) == sign(player.direction):
		new_speed = sign(new_speed) * max(abs(new_speed), abs(player.velocity.x))

	player.velocity.x = move_toward(player.velocity.x, new_speed, step)


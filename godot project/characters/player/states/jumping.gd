
class_name Jumping
extends InAir

func _ready() -> void:
	animation_name = "Jump"

func enter() -> void:

	player.velocity.y = PlayerConstants.JUMP_VELOCITY
	player.velocity.x *= PlayerConstants.BHOP_MULTIPLIER

	player.move_and_slide()

	animation.try_play(animation_name)

func physics_update(delta: float) -> void:
	super(delta)

func _process(_delta: float) -> void:
	pass


class_name Jumping
extends State

func enter() -> void:

	player_stats.velocity.y = constants.JUMP_VELOCITY
	player_stats.velocity.x *= constants.BHOP_MULTIPLIER

	player_stats.is_on_floor = false

	player.position = player_stats.position
	player.velocity = player_stats.velocity

	player.move_and_slide()
	
	player_stats.position = player.position
	player_stats.velocity = player.velocity

	animation.play("Jump")

func physics_update(delta: float) -> void:
	super(delta)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

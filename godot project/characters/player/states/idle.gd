
class_name Idle
extends PlayerState

func _ready() -> void:
	animation_name = "Idle"

func enter() -> void:
	animation.play(animation_name)

func can_move() -> bool:
	
	var normal_move: bool = player.move_and_collide(Vector2(player.direction, 0), true) == null
	var ramp_move: bool = player.move_and_collide(Vector2(player.direction, -1), true) == null
	
	return normal_move or ramp_move

func physics_update(delta: float) -> void:
	
	if player.direction and can_move():
		transitioned.emit(self, "walking")
		return

	if try_basic_change():
		return
	
	if not player.is_on_floor():
		player.velocity.y += delta * GameConstants.GRAVITY


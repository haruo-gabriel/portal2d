
class_name Idle
extends PlayerState

func enter() -> void:
	animation.play("Idle")

func physics_update(delta: float) -> void:
	
	if player.direction and not player.move_and_collide(Vector2(player.direction, 0), true):
		transitioned.emit(self, "walking")
		return

	if try_basic_change():
		return
	
	if not player.is_on_floor():
		player.velocity.y += delta * GameConstants.GRAVITY


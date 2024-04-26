
class_name Idle
extends PlayerState

func enter() -> void:
	animation.play("Idle")

func physics_update(delta: float) -> void:

	if try_basic_change():
		return
	
	if not player_stats.is_on_floor:
		player_stats.velocity.y += delta * game_constants.GRAVITY

	if player_stats.direction and not player.move_and_collide(Vector2(player_stats.direction, 0), true):
		transitioned.emit(self, "walking")
		return

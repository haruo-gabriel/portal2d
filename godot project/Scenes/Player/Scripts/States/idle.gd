
class_name Idle
extends PlayerState

func enter() -> void:
	animation.play("Idle")

func physics_update(delta: float) -> void:

	var new_state: String = check_basic_change()

	if new_state != "" and new_state != "idle":
		transitioned.emit(self, new_state)
		return

	if player_stats.direction and not player.move_and_collide(Vector2(player_stats.direction, 0), true):
		transitioned.emit(self, "walking")
		return

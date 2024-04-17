
class_name Idle
extends State

func enter() -> void:
	animation.play("Idle")

func physics_update(delta: float) -> void:
	
	if player_stats.direction and not player.move_and_collide(Vector2(player_stats.direction, 0), true):
		transitioned.emit(self, "walking")
		return 

	super(delta)

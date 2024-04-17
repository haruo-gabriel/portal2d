
class_name Idle
extends State

func enter() -> void:
	animation.play("Idle")

func physics_update(delta: float) -> void:
	
	if player_stats.direction:
		transitioned.emit(self, "walking")
		return 

	super(delta)

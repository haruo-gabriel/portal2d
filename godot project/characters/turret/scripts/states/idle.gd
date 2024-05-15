
class_name TurretIdle
extends TurretState

func on_enter() -> void:
	pass

func update(_delta: float) -> void:

	var angle_to: float = (player.position - turret.position).angle()
	
	if angle_to >= turret.minimum_angle and angle_to <= turret.maximum_angle:
		transitioned.emit(self, "Active")
	

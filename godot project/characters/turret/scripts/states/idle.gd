
class_name TurretIdle
extends TurretState

func on_enter() -> void:
	pass

func update(_delta: float) -> void:
	
	if can_see_player():
		transitioned.emit(self, "Active")
	
	turret.angle = move_toward(turret.angle, turret.maximum_angle, turret.rotation_speed)

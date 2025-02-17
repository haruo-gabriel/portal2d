
class_name TurretIdle
extends TurretState

func on_enter() -> void:
	pass

func update(_delta: float) -> void:

	if can_see_target():
		transitioned.emit(self, "Active")

	turret.angle = get_new_angle(turret.rest_angle)

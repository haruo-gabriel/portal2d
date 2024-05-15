
class_name TurretActive
extends TurretState

func enter() -> void:
	turret.get_node("HeadSprite").modulate = Color.RED

func exit() -> void:
	turret.modulate = Color.WHITE

func physics_update(delta: float) -> void:

	turret.angle = move_toward(turret.angle, angle_to_player, .1)

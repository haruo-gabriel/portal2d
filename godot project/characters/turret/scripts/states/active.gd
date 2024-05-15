
class_name TurretActive
extends TurretState

func enter() -> void:
	turret.get_node("HeadSprite").modulate = Color.RED

func exit() -> void:
	turret.get_node("HeadSprite").modulate = Color.WHITE

func update(_delta: float) -> void:
	
	if not can_see_player():
		transitioned.emit(self, "Idle")

func physics_update(delta: float) -> void:

	turret.angle = move_toward(turret.angle, angle_to_player, .1)

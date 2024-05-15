
class_name TurretActive
extends TurretState

func enter() -> void:
	turret.get_node("HeadSprite").modulate = Color.RED

func exit() -> void:
	turret.modulate = Color.WHITE

func _process(delta: float) -> void:
	pass

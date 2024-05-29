
class_name MovingEnemyState
extends State

var enemy: MovingEnemy

func start() -> void:
	enemy = entity

func can_see(caster: RayCast2D) -> bool:

	if not caster.is_colliding():
		return false

	if not caster.get_collider():
		return false
	
	return caster.get_collider().is_in_group("MovingEnemyTarget")

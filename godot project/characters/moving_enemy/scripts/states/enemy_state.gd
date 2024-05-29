
class_name MovingEnemyState
extends State

var enemy: MovingEnemy

func start() -> void:
	enemy = entity

func can_see_ahead(distance: float) -> bool:

	enemy.player_caster.target_position = enemy.velocity.normalized() * distance

	if not enemy.player_caster.is_colliding():
		return false

	if not enemy.player_caster.get_collider():
		return false
	
	return enemy.player_caster.get_collider().is_in_group("MovingEnemyTarget")

func can_see_behind(distance: float) -> bool:

	enemy.player_caster2.target_position = - enemy.velocity.normalized() * distance

	if not enemy.player_caster2.is_colliding():
		return false

	if not enemy.player_caster2.get_collider():
		return false
	
	return enemy.player_caster2.get_collider().is_in_group("MovingEnemyTarget")


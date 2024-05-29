
extends MovingEnemyState

const SEARCH_SPEED: float = 100

func enter() -> void:
	enemy.velocity.x = sign(enemy.velocity.x) * SEARCH_SPEED

func look_around() -> int:
	
	if can_see_ahead(enemy.SIGHT_DISTANCE):
		return 1
	
	if can_see_behind(enemy.BEHIND_SIGHT_DISTANCE):
		return -1
	
	return 0

func try_chase() -> void:
	
	var seen: int = look_around()

	if not seen:
		return

	if seen < 0:
		enemy.flip()

	transitioned.emit(self, "chasing")


func physics_update(delta: float) -> void:

	if not enemy.velocity.x:
		enemy.velocity.x = SEARCH_SPEED

	if not enemy.is_on_floor():
		enemy.velocity.y += GameConstants.GRAVITY * delta

	if enemy.should_flip(delta):
		enemy.flip()

	try_chase()


extends MovingEnemyState

const CHASE_SPEED: float = 200
const LAST_SEEN_TIME: int = 180

var last_seen: int

func enter() -> void:

	entity.velocity.x = sign(entity.velocity.x) * CHASE_SPEED

	last_seen = LAST_SEEN_TIME

func physics_update(delta: float) -> void:
	
	if not enemy.velocity.x:
		enemy.velocity.x = CHASE_SPEED

	if not enemy.is_on_floor():
		enemy.velocity.y += GameConstants.GRAVITY * delta

	if enemy.should_flip(delta):
		enemy.flip()
	
	if can_see_ahead(enemy.SIGHT_DISTANCE):
		last_seen = LAST_SEEN_TIME
	
	elif can_see_behind(enemy.BEHIND_SIGHT_DISTANCE):
		last_seen = LAST_SEEN_TIME
		enemy.flip()

	else:
		last_seen -= 1
	
	if last_seen == 0:
		transitioned.emit(self, "searching")
		return


extends MovingEnemyState

const SEARCH_SPEED: float = 100

func enter() -> void:
	
	enemy.velocity.x = sign(enemy.velocity.x) * SEARCH_SPEED
	
	if enemy.animation != null:
		enemy.animation.play("search")

func look_around() -> int:
	
	if can_see(enemy.player_caster):
		return 1
	
	if can_see(enemy.player_caster2):
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

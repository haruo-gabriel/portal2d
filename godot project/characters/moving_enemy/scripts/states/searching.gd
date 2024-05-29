
extends MovingEnemyState

const SEARCH_SPEED: int = 100

func should_flip(delta: float) -> bool:
	
	if not entity.can_see_floor.is_colliding():
		return true

	var collision: KinematicCollision2D = entity.move_and_collide(Vector2(entity.velocity.x * delta, 0), true)

	if collision == null:
		return false

	var normal: Vector2 = collision.get_normal()

	return is_zero_approx(normal.y)

func physics_update(delta: float) -> void:

	if not entity.velocity.x:
		entity.velocity.x = SEARCH_SPEED

	if not entity.is_on_floor():
		entity.velocity.y += GameConstants.GRAVITY * delta

	if should_flip(delta):
		entity.flip(delta)

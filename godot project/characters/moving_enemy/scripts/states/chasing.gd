
extends MovingEnemyState

const CHASE_SPEED: float = 200
const LAST_SEEN_TIME: int = 180

const ATTACK_TRIGGER: int = 1

var last_seen: int

func enter() -> void:

	entity.velocity.x = sign(entity.velocity.x) * CHASE_SPEED

	last_seen = LAST_SEEN_TIME

	enemy.animation.play("chase")

func basic_action(delta: float) -> void:

	if not enemy.velocity.x:
		enemy.velocity.x = CHASE_SPEED

	if not enemy.is_on_floor():
		enemy.velocity.y += GameConstants.GRAVITY * delta

	if enemy.should_flip(delta):
		enemy.flip()

func physics_update(delta: float) -> void:
	
	basic_action(delta)
	
	if can_see(enemy.attack_caster):
		transitioned.emit(self, "attacking")
		return
	
	if can_see(enemy.player_caster):
		last_seen = LAST_SEEN_TIME
	
	elif can_see(enemy.player_caster2):
		last_seen = LAST_SEEN_TIME
		enemy.flip()

	else:
		last_seen -= 1
	
	if last_seen == 0:
		transitioned.emit(self, "searching")
		return

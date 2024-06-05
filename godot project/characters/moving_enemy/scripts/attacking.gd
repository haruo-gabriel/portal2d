
extends MovingEnemyState

const ATTACK_DELAY: int = 60 * .4
const ATTACK_DURATION: int = 60 * .3
const POST_ATTACK_DELAY: int = 60 * .2

const REACH: int = 50

var attack_delay: int
var attack_duration: int
var post_attack_delay: int


func enter() -> void:
	
	attack_delay = ATTACK_DELAY
	attack_duration = ATTACK_DURATION
	post_attack_delay = POST_ATTACK_DELAY

	enemy.animation.play("attack")
	enemy.animation.seek(0, true)
	
	enemy.velocity.x = sign(enemy.velocity.x)

func _physics_process(delta: float) -> void:
	
	if attack_delay:
		attack_delay -= 1
		return
	
	enemy.attack_area.monitoring = true
	
	if attack_duration:
		attack_duration -= 1
		return
	
	enemy.attack_area.monitoring = false
	
	post_attack_delay -= 1
	
	if not post_attack_delay:
		transitioned.emit(self, "searching")


func _on_attack_area_body_entered(body: Node2D) -> void:

	if not body.is_in_group("MovingEnemyTarget"):
		return
	
	body.health.take_damage(enemy.damage)


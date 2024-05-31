
extends MovingEnemyState

const ATTACK_DELAY: int = 10
const ATTACK_DURATION: int = 30
const POST_ATTACK_DELAY: int = 60

const REACH: int = 50

var attack_delay: int
var attack_duration: int
var post_attack_delay: int


func enter() -> void:
	
	attack_delay = ATTACK_DELAY
	attack_duration = ATTACK_DURATION
	post_attack_delay = POST_ATTACK_DELAY

	enemy.animation.play("attack")
	
	enemy.velocity = enemy.velocity.normalized() / 10

func exit() -> void:
	pass

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
	
	body.health.take_damage(100)


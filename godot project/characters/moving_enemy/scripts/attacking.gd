
extends MovingEnemyState

const ATTACK_DELAY: int = 10
const POST_ATTACK_DELAY: int = 60

const REACH: int = 50

var attack_delay: int
var post_attack_delay: int

func attack() -> void:
	pass

func _ready() -> void:
	attack_delay = ATTACK_DELAY
	post_attack_delay = POST_ATTACK_DELAY


func _physics_process(delta: float) -> void:
	
	if attack_delay:
		attack_delay -= 1
		return
	
	if post_attack_delay == POST_ATTACK_DELAY:
		attack()
	
	post_attack_delay -= 1
	
	if not post_attack_delay:
		transitioned.emit(self, "searching")
	

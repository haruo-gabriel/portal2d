
class_name TurretSearching
extends TurretState

const search_time: int = 180

var t: float
var direction: float
var life_time: int

func enter() -> void:

	life_time = search_time

	t = angle_to_player - turret.minimum_angle
	direction = 1 if randf() > .5 else -1

func get_angle() -> float:
	
	var diff: float = turret.maximum_angle - turret.minimum_angle

	return turret.minimum_angle + (sin(direction * t / 20.0) + 1) / 2 * diff

func physics_update(_delta: float) -> void:
	
	if life_time > 0:
		life_time -= 1
	else:
		transitioned.emit(self, "Idle")
		return
	
	turret.angle = get_angle()

	t += 1

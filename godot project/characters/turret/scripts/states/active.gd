
class_name TurretActive
extends TurretState

const last_seen_time: int = 100

var open_cooldown: int
var last_seen: int

func enter() -> void:
	
	last_seen = last_seen_time
	
	open_cooldown = turret.open_cooldown

func physics_update(delta: float) -> void:

	if open_cooldown > 0:
		open_cooldown -= 1
		return

	if can_see_player():
		last_seen = last_seen_time
	else:
		
		if last_seen > 0:
			last_seen -= 1
			return

		transitioned.emit(self, "Idle")
		return

	if not open_cooldown and last_seen:
		turret.angle = move_toward(turret.angle, angle_to_player, turret.rotation_speed)

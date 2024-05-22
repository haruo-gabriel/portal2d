
class_name TurretState
extends State

var turret: Turret
var target: CharacterBody2D

var angle_to_player: float

func can_see_target() -> bool:
	
	if target == null:
		return false
	
	return turret.can_see(target.position)

func get_new_angle(angle: float) -> float:
	
	if abs(angle - turret.angle) < PI:
		return move_toward(turret.angle, angle, turret.rotation_speed)
	
	if angle > turret.angle:
		return move_toward(turret.angle, angle - TAU, turret.rotation_speed)
	
	return move_toward(turret.angle, angle + TAU, turret.rotation_speed)

func start() -> void:
	turret = entity

func _ready() -> void:
	pass

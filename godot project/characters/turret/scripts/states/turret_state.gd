
class_name TurretState
extends State

var turret: Turret
var target: CharacterBody2D

var angle_to_player: float

func can_see_target() -> bool:
	
	if target == null:
		return false
	
	return turret.can_see(target.position)

func start() -> void:
	turret = entity

func _ready() -> void:
	pass

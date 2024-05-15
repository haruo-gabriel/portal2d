
class_name TurretState
extends State

var turret: Turret
var player: Player

var angle_to_player: float

func can_see_player() -> bool:

	if angle_to_player < turret.minimum_angle or angle_to_player > turret.maximum_angle:
		return false

	turret.raycast.target_position = 2 * (player.global_position + Vector2(0, -10) - turret.raycast.global_position)

	return turret.raycast.get_collider() is Player


func start() -> void:
	turret = entity

func _ready() -> void:
	pass

func _physics_process(delta) -> void:

	angle_to_player = (player.position - turret.position).angle()

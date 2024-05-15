
class_name TurretState
extends State

var turret: Turret
var player: Player

var angle_to_player: float

func start() -> void:
	turret = entity

func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	angle_to_player = (player.position - turret.position).angle()

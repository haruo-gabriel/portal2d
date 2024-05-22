
class_name Turret
extends StaticBody2D

@onready var head_sprite: Sprite2D = $HeadSprite
@onready var head_shape: CollisionShape2D = $HeadShape

@onready var raycast: RayCast2D = $RayCast2D
@onready var machine: TurretStateMachine = $StateMachine

@export var minimum_angle: float
@export var maximum_angle: float

@export var radius: float = 200

@export var rotation_speed: float = .01
@export var open_cooldown: int = 60

var LASER_SCENE: Resource = preload("res://characters/laser/laser.tscn")

var angle: float = 0.0

func can_see(target: Vector2) -> bool:

	var diff: Vector2 = target - raycast.global_position
	var angle: float = diff.angle()

	raycast.target_position = 1.5 * diff + Vector2(0, -10)

	return not raycast.get_collider() is TileMap

func shoot(target: Vector2) -> void:
	
	var laser: Laser = LASER_SCENE.instantiate()
	
	var diff: Vector2 = target - raycast.global_position
	
	laser.start_position = raycast.global_position
	laser.velocity = diff.normalized() * 2000
	
	get_parent().add_child(laser)

func _ready() -> void:
	get_node("DetectionArea").get_node("CollisionShape2D").shape.radius = radius

func _process(delta: float) -> void:

	head_sprite.rotation = angle
	head_shape.rotation = angle

func _on_detection_area_body_entered(body: Node2D) -> void:
	
	if not body.is_in_group("TurretTarget"):
		return

	machine.target = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	
	if body == machine.target:
		machine.target = null
	

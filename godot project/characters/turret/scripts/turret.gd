
class_name Turret
extends StaticBody2D

@onready var head_sprite: Sprite2D = $HeadSprite
@onready var head_shape: CollisionShape2D = $HeadShape

@onready var raycast: RayCast2D = $RayCast2D
@onready var machine: TurretStateMachine = $StateMachine

@export var minimum_angle: float
@export var maximum_angle: float

@export var rotation_speed: float = .01
@export var open_cooldown: int = 2

var angle: float = 0.0

func can_see(target: Vector2) -> bool:

	var diff: Vector2 = target - raycast.global_position
	var angle: float = diff.angle()

	if angle > maximum_angle or angle < minimum_angle:
		return false

	raycast.target_position = 1.5 * diff

	return not raycast.get_collider() is TileMap

func _ready() -> void:
	pass

func _process(delta: float) -> void:

	head_sprite.rotation = angle
	head_shape.rotation = angle

func _on_detection_area_body_entered(body: Node2D) -> void:
	
	if not body.is_in_group("TurretTarget"):
		return

	machine.target = body

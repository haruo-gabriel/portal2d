
class_name Turret
extends StaticBody2D

@onready var head_sprite: Sprite2D = $HeadSprite
@onready var head_shape: CollisionShape2D = $HeadShape

@onready var raycast: RayCast2D = $RayCast2D

@export var minimum_angle: float
@export var maximum_angle: float

@export var rotation_speed: float
@export var open_cooldown: int

@export var player: Player

var angle: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:

	head_sprite.rotation = angle
	head_shape.rotation = angle

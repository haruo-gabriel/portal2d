
class_name Turret
extends StaticBody2D

@onready var head_sprite: Sprite2D = $HeadSprite
@onready var head_shape: CollisionShape2D = $HeadShape

var angle: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:

	head_sprite.rotation = angle
	head_shape.rotation = angle

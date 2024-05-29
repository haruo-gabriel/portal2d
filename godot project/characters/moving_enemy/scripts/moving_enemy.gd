
class_name MovingEnemy
extends CharacterBody2D

@onready var can_see_floor: RayCast2D = $FloorCaster

func flip(delta: float) -> void:
	velocity.x *= -1
	can_see_floor.position.x *= -1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()


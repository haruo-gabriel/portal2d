
class_name MovingEnemy
extends CharacterBody2D

@export var can_fall: bool = false

@onready var can_see_floor: RayCast2D = $FloorCaster

@onready var player_caster: RayCast2D = $PlayerCaster
@onready var player_caster2: RayCast2D = $PlayerCaster2

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

const SIGHT_DISTANCE: float = 500
const BEHIND_SIGHT_DISTANCE: float = 100

func flip() -> void:
	
	velocity.x *= -1
	
	can_see_floor.position *= -1
	sprite.flip_h = not sprite.flip_h
	
	player_caster.target_position = -player_caster.target_position
	player_caster2.target_position = -player_caster2.target_position
	


func flip_to(direction: int) -> void:
	
	if not direction:
		return
	
	if (direction > 0) == (velocity.x > 0):
		flip()

func should_flip(delta: float) -> bool:
	
	if not can_fall and not can_see_floor.is_colliding():
		return true

	var collision: KinematicCollision2D = move_and_collide(Vector2(velocity.x * delta, 0), true)

	if collision == null:
		return false

	var normal: Vector2 = collision.get_normal()

	return is_zero_approx(normal.y)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()


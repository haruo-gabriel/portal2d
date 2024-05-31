
class_name MovingEnemy
extends CharacterBody2D

@export var can_fall: bool = false

@onready var can_see_floor: RayCast2D = $FloorCaster

@onready var player_caster: RayCast2D = $PlayerCaster
@onready var player_caster2: RayCast2D = $PlayerCaster2
@onready var attack_caster: RayCast2D = $AttackCaster

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var attack_area: Area2D = $AttackArea
@onready var attack_shape: CollisionShape2D = attack_area.get_node("CollisionShape2D")

const SIGHT_DISTANCE: float = 500
const BEHIND_SIGHT_DISTANCE: float = 100

func flip() -> void:
	
	velocity.x *= -1
	
	can_see_floor.position *= -1
	sprite.flip_h = not sprite.flip_h
	
	player_caster.target_position *= -1
	player_caster2.target_position *= -1
	attack_caster.target_position *= -1
	
	attack_shape.position *= -1


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
	animation.play("searching")

func _physics_process(delta: float) -> void:
	move_and_slide()



class_name Laser
extends Node2D

var velocity: Vector2
var start_position: Vector2
var life_time: int

var max_distance: float = 1000 # Maximum distance from starting position
var max_life_time: int = 1000 # In game ticks

func _ready() -> void:
	life_time = max_life_time
	position = start_position

func _physics_process(delta: float) -> void:

	rotation = velocity.angle()
	position += velocity * delta

	if (start_position - position).length() > max_distance:
		queue_free()

	life_time -= 1
	
	if life_time <= 0:
		queue_free()
	

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("TurretTarget"):
		body._on_laser_hit(self)
	
	if body.is_in_group("LaserWall"):
		queue_free()


class_name PlayerIdle
extends PlayerState

func _ready() -> void:
	animation_name = "Idle"

func enter() -> void:
	animation.try_play(animation_name)

func can_move() -> bool:
	
	if player.move_and_collide(Vector2(player.direction, 0), true) == null:
		return true
	
	if player.move_and_collide(Vector2(player.direction, -1), true) == null:
		return true

	return false

func physics_update(delta: float) -> void:
	
	if player.direction and can_move():
		transitioned.emit(self, "walking")
		return
	
	if try_basic_change():
		return
	
	player.velocity.y += delta * GameConstants.GRAVITY


class_name PlayerFalling
extends PlayerInAir

func _ready() -> void:
	animation_name = "Fall"

func enter() -> void:
	
	player.is_falling = true
	
	animation.try_play(animation_name)

func exit() -> void:
	
	player.is_falling = false

func physics_update(delta: float) -> void:
	super(delta)

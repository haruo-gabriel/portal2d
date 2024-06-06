extends Area2D


@export var screen_transition: CanvasLayer


func _on_body_entered(body):
	if body is Player:
		screen_transition.transition()

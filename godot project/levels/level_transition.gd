
class_name LevelTransition
extends Area2D

signal transitioned

@export var screen_transition: CanvasLayer


func _on_body_entered(body: Node2D) -> void:

	if body is Player:
		screen_transition.transition()
		transitioned.emit()

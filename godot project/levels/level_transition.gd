
class_name LevelTransition
extends Area2D

signal transitioned

@export var screen_transition: CanvasLayer


func _on_body_entered(body: Node2D) -> void:

	if body is Player:
		AudioManager.fade_out($"../LevelMusic", 1.0)
		screen_transition.transition()
		transitioned.emit()

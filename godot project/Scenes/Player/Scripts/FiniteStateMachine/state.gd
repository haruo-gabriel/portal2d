
class_name State
extends Node

signal transitioned

@onready var animation: AnimationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

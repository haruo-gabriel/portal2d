
class_name State
extends Node

signal transitioned(state: State, new_state_name: String)

var entity: Node

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

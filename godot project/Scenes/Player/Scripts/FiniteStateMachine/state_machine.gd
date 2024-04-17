
extends Node

var current_state: State
var states: Dictionary = {}

func _ready() -> void:

	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.trasi

func _process(delta: float) -> void:

	if current_state != null:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	
	if current_state != null:
		current_state.physics_update(delta)

func _on_child_transitioned(state: State, new_state: State) -> void:

	if state != current_state:
		return print("Invalid Caller")

	pass

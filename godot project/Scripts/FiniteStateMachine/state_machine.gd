
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:

	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transitioned)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:

	if current_state != null:
		current_state.update(delta)

func _physics_process(delta: float) -> void:

	if current_state != null:
		current_state.physics_update(delta)

func _on_child_transitioned(state: State, new_state_name: String) -> void:

	if state != current_state:
		return print("Invalid Caller, must be the same as current")

	if new_state_name.to_lower() not in states:
		return print("Invalid New State Name")

	var new_state: State = states[new_state_name.to_lower()]

	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state


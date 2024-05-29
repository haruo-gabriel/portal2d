
class_name StateMachine
extends Node

@export var initial_state: State
@export var entity: Node

var current_state: State
var states: Dictionary = {}

func get_states() -> Array:
	
	var _states: Array = Array()

	for child in get_children():
		if child is State:
			_states.append(child)

	return _states

func transition(state: State, new_state_name: String) -> void:
	
	if state != current_state:
		return print("Invalid Caller, must be the same as current")
	
	if new_state_name.to_lower() not in states:
		return print("Invalid New State Name")

	var new_state: State = states[new_state_name.to_lower()]

	if new_state == current_state:
		return

	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state


func _ready() -> void:

	for state in get_states():

		states[state.name.to_lower()] = state
		
		state.transitioned.connect(_on_child_transitioned)
		state.entity = entity
		state.start()

	current_state = initial_state
	initial_state.enter()

func _process(delta: float) -> void:

	if current_state != null:
		current_state.update(delta)

func _physics_process(delta: float) -> void:

	if current_state != null:
		current_state.physics_update(delta)

func _on_child_transitioned(state: State, new_state_name: String) -> void:
	transition(state, new_state_name)

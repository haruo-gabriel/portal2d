
class_name TurretStateMachine
extends StateMachine

var target: CharacterBody2D

func _ready() -> void:
	super()

	for state in states.values():
		state.turret = entity

func _process(delta: float) -> void:
	super(delta)

	if target == null:
		return
	
	for state in states.values():
		state.target = target

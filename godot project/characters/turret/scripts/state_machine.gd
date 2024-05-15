
class_name TurretStateMachine
extends StateMachine

var player: Player

func _ready() -> void:
	super()

	for state in states.values():
		state.player = player

func _process(delta) -> void:
	pass

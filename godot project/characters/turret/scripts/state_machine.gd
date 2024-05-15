
class_name TurretStateMachine
extends StateMachine

var player: Player

func find_player() -> void:
	
	for child in entity.get_parent().get_children():
		if child is Player:
			player = child

func _ready() -> void:
	super()

	find_player()

	for state in states.values():
		state.player = player

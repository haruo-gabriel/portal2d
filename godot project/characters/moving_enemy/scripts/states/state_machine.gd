
extends StateMachine

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)

func _on_player_sight_area_body_entered(body: Node2D) -> void:

	if not body.is_in_group("MovingEnemyTarget"):
		return
		
	current_state.transitioned.emit(current_state, "chasing")

func _on_player_attack_area_body_entered(body: Node2D) -> void:

	if not body.is_in_group("MovingEnemyTarget"):
		return

	current_state.transitioned.emit(current_state, "attack")

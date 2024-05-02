
class_name PlayerAnimation
extends AnimationPlayer

@export var player: Player

@onready var state_machine: StateMachine = player.get_node("StateMachine")

func try_play(name: String) -> void:
	
	if player.is_crouching:
		return
	
	play(name)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:

	var is_crouched_animation: bool = "(Crouched)" in current_animation

	if player.is_crouching and (not is_crouched_animation or not player.is_on_floor()):
		play("Idle (Crouched)")

	if not player.is_crouching and is_crouched_animation:
		play(state_machine.current_state.animation_name)

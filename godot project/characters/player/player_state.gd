
class_name PlayerState
extends State

var player: Player

var animation: AnimationPlayer :
	get: return entity.get_node("AnimationPlayer")

@onready var game_constants: GameConstants = load("res://characters/common/game_constants.tres")
@onready var player_constants: PlayerConstants = load("res://characters/player/player_constants.tres")

func _ready() -> void:
	player = entity

func check_basic_change() -> String:
	
	if player.jumped:
		return "jumping"
	
	if not player.velocity.x and player.is_on_floor():
		return "idle"
	
	if player.velocity.x and player.is_on_floor:
		return "walking"
	
	if not player.is_on_floor() and player.velocity.y >= 0: # If current state is "falling", this should be ignored
		return "falling"
	
	return ""

func try_basic_change() -> bool:
	
	var new_state: String = check_basic_change()

	if new_state == "" or new_state.to_lower() == self.name.to_lower():
		return false

	transitioned.emit(self, new_state)

	return true

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

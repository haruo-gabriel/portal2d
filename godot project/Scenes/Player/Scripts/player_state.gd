
class_name PlayerState
extends State

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var animation: AnimationPlayer = player.get_node("AnimationPlayer")

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func check_basic_change() -> String:
	
	print(player_stats.is_on_floor, player.velocity)
	
	if player_stats.jumped:
		return "jumping"
	
	if not player_stats.velocity.x and player_stats.is_on_floor:
		return "idle"
	
	if player_stats.velocity.x and player_stats.is_on_floor:
		return "walking"
	
	if not player_stats.is_on_floor and player_stats.velocity.y >= 0: # If current state is "falling", this should be ignored
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

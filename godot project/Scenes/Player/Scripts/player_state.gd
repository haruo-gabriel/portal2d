
class_name PlayerState
extends State

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var animation: AnimationPlayer = player.get_node("AnimationPlayer")

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func check_basic_change() -> String:
	
	if player_stats.jumped:
		return "jumping"
	
	if not player_stats.velocity.x and player_stats.is_on_floor:
		return "idle"
	
	if player_stats.velocity.x and player_stats.is_on_floor:
		return "walking"
	
	if player_stats.velocity.y < 0: # If current state is "falling", this should be ignored
		return "falling"
	
	return ""

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

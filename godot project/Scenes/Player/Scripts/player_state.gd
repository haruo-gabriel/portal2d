
class_name PlayerState
extends State

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var animation: AnimationPlayer = player.get_node("AnimationPlayer")

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:

	if player_stats.jumped:
		transitioned.emit(self, "jumping")
		return

	if not player_stats.is_falling and player_stats.velocity.y < 0:
		transitioned.emit(self, "falling")
		return

	if not player_stats.velocity.x and player_stats.is_on_floor:
		transitioned.emit(self, "idle")
		return
	
	if not player_stats.is_on_floor:
		player_stats.velocity.y += gravity * delta

	else:
		if player_stats.velocity.x: transitioned.emit(self, "walking")
		else: transitioned.emit(self, "idle")

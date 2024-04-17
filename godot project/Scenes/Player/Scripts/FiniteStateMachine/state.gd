
class_name State
extends Node

signal transitioned(state: State, new_state_name: String)

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var animation: AnimationPlayer = player.get_node("AnimationPlayer")

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:

	if not player_stats.velocity.x and player_stats.is_on_floor:
		transitioned.emit(self, "idle")

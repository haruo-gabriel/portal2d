
class_name Health
extends Node

const REGENERATION_COOLDOWN: int = 60 # measured in frames

signal died

@export var max_health: float
@export var regeneration: float # HP / frame

var health: float

var _time_since_last_hit: int # frames

func _set_health(new_hp: float) -> void:
	
	if new_hp <= 0:
		died.emit()
	
	if new_hp < health:
		_time_since_last_hit = 0
	
	health = clamp(new_hp, 0, max_health)

func _ready() -> void:
	
	health = max_health

func _process(_delta: float) -> void:
	
	if _time_since_last_hit >= REGENERATION_COOLDOWN:
		health += regeneration
	else:
		_time_since_last_hit += 1

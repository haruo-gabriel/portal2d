
class_name Health
extends Node

const REGENERATION_COOLDOWN: int = 60 # measured in frames

signal died

@export var max_health: float
@export var regeneration: float # HP / frame

var _health: float

var health: float :
	get: 
		return _health
	
	set (value): 
		_set_health(value)

var _time_since_last_hit: int # frames

func take_damage(damage: float) -> void:
	health -= damage

func heal(healing: float) -> void:
	health += healing

func _set_health(new_hp: float) -> void:
	
	if new_hp <= 0:
		died.emit()
	
	if new_hp < _health:
		_time_since_last_hit = 0
	
	_health = clamp(new_hp, 0, max_health)

func _ready() -> void:
	
	health = max_health

func _process(_delta: float) -> void:
	
	if _time_since_last_hit >= REGENERATION_COOLDOWN:
		heal(regeneration)
	else:
		_time_since_last_hit += 1

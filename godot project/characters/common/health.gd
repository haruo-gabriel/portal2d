
class_name Health
extends Node


signal died
signal got_hit(damage: int)
signal reached_full_health

@export var max_health: float
@export var regeneration: float # HP / frame

var regeneration_cooldown: int = 300 # measured in frames

var _health: float

var health: float :
	get: 
		return _health
	
	set (value): 
		_set_health(value)

var _time_since_last_hit: int # frames

func take_damage(damage: float) -> void:

	health -= damage

	got_hit.emit(damage)

func heal(healing: float) -> void:
	health += healing

func _set_health(new_hp: float) -> void:
	
	if new_hp <= 0:
		died.emit()
	
	if new_hp < _health:
		_time_since_last_hit = 0
	
	if new_hp >= max_health and _health < max_health:
		reached_full_health.emit()
	
	_health = clamp(new_hp, 0, max_health)

func _ready() -> void:
	health = max_health

func _process(_delta: float) -> void:
	
	if _time_since_last_hit >= regeneration_cooldown:
		
		if health < max_health:
			heal(regeneration)
		
	else:
		_time_since_last_hit += 1

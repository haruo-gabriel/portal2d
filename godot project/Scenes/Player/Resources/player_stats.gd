
class_name PlayerStats
extends Resource

var position: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

var direction: float = 1.0

var angle: float = 0.0

var is_crouching: bool = false
var is_on_floor: bool = false # Initial value does not matter

var last_jumped: int = 0 # Frames since last jump input
var jumped: bool = false # Whether the player just jumped

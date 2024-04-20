
class_name Player
extends CharacterBody2D

@onready var stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

@onready var main_hitbox: CollisionShape2D = $MainHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

@onready var raycast: RayCast2D = $RayCast2D

@onready var tile_map: TileMap = get_parent().get_node("TileMap")

const TILE_SIZE: float = 64.0

func get_coords() -> Vector2i:
	
	var hit: Vector2 = raycast.get_collision_point()
	var normal: Vector2 = raycast.get_collision_normal()
	
	if hit == null or normal == null:
		return Vector2i(-999, -999)
	
	var x: int = floor((hit.x - TILE_SIZE * normal.x / 2.0) / TILE_SIZE)
	var y: int = floor((hit.y - TILE_SIZE * normal.y / 2.0) / TILE_SIZE)

	return Vector2i(x, y)

func shoot() -> void:
	
	var coord: Vector2i = get_coords()

	print(coord)
func set_angle() -> void:
	
	var difference: Vector2 = get_global_mouse_position() - (global_position + constants.PLAYER_CENTER)

	if difference: 
		stats.angle = atan2(difference.y, difference.x)

func toggle_hitbox(to_crouch: bool) -> void:

	main_hitbox.disabled = to_crouch
	crouched_hitbox.disabled =  not to_crouch

	stats.is_crouching = to_crouch

func toggle_crouch(to_crouch: bool) -> void:

	toggle_hitbox(to_crouch)

	# We want it to not collide with anything after changin the hitbox
	if move_and_collide(Vector2.ZERO, true):
		toggle_hitbox(not to_crouch)

func try_jump() -> void:
	
	if Input.is_action_just_pressed("jump"):
		stats.last_jumped = constants.JUMP_BUFFER_TIME

	if stats.last_jumped and stats.is_on_floor:
		stats.last_jumped = 0
		stats.jumped = true
	else:
		stats.jumped = false

	stats.last_jumped = max(0, stats.last_jumped - 1)

func move() -> void:
	
	try_jump()

	velocity.x = clamp(velocity.x, -constants.MAX_X_SPEED, constants.MAX_X_SPEED)
	velocity.y = clamp(velocity.y, -constants.MAX_Y_SPEED, constants.MAX_Y_SPEED)

	position = stats.position
	velocity = stats.velocity

	move_and_slide()

	stats.position = position
	stats.velocity = velocity

func _ready() -> void:
	
	stats.position = position
	stats.velocity = velocity

func _process(_delta: float) -> void:

	stats.is_on_floor = is_on_floor()
	stats.direction = Input.get_axis("move_left", "move_right")

	var try_crouch = Input.is_action_pressed("crouch")

	if try_crouch and not stats.is_crouching:
		toggle_crouch(true)
	
	if not try_crouch and stats.is_crouching:
		toggle_crouch(false)

	if Input.is_action_just_pressed("shoot_portal1"):
		shoot()

	set_angle()

func _physics_process(_delta: float) -> void:
	move()

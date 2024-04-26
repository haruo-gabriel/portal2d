
class_name Player
extends CharacterBody2D

@onready var stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

@onready var main_hitbox: CollisionShape2D = $MainHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

@onready var raycast: RayCast2D = $RayCast2D
@onready var tile_map: TileMap = get_parent().get_node("TileMap")

@onready var game_constants: GameConstants = load("res://Scripts/Resources/game_constants.tres")

@onready var SPACE_STATE: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state

const DIVISIONS: int = 200
const CASTS: int = 10

func to_coord(pos: Vector2) -> Vector2i:
	return Vector2i(pos / game_constants.TILE_SIZE)

func fix_pos(pos: Vector2, normal: Vector2) -> Vector2:
	
	if abs(normal.x) > 0.9: pos.x -= normal.x
	if abs(normal.y) > 0.9: pos.y -= normal.y

	return pos

func is_valid_square(pos: Vector2, normal: Vector2) -> bool:
	
	var query = PhysicsRayQueryParameters2D.create(pos + 10 * normal, pos - 10 * normal)
	
	query.exclude = [self]

	var result: Dictionary = SPACE_STATE.intersect_ray(query)

	if not result:
		return false
	
	if result.normal != normal:
		return false

	result.position = fix_pos(result.position, result.normal)

	var coord = to_coord(result.position)
	var tile = tile_map.get_cell_tile_data(0, coord)

	return tile.get_custom_data("CanPortal")

func get_valid_squares(pos: Vector2, normal: Vector2) -> Dictionary:
	
	var squares: Dictionary = Dictionary()

	var step: Vector2 = game_constants.PORTAL_SIZE * game_constants.TILE_SIZE * normal.rotated(PI / 2) / CASTS
	var current: Vector2 = pos

	while is_valid_square(current, normal):

		squares[to_coord(current)] = true

		current += step

	current = pos

	while is_valid_square(current, normal):

		squares[to_coord(current)] = true

		current -= step

	return squares

func shoot() -> void:

	var hit: Vector2 = raycast.get_collision_point()
	var normal: Vector2 = raycast.get_collision_normal()

	if hit == Vector2.ZERO or hit == null or normal == null:
		return
	
	hit -= tile_map.position
	hit = fix_pos(hit, normal)

	var rotated: Vector2 = normal.rotated(PI / 2)
	var squares: Dictionary = get_valid_squares(hit, normal)

	if len(squares) < game_constants.PORTAL_SIZE:
		return

	var span1: float = 0.0
	var span2: float = 0.0

	var step: float = game_constants.PORTAL_SIZE / DIVISIONS

	while Vector2i(hit / game_constants.TILE_SIZE + span1 * rotated) in squares:
		span1 += step

	while Vector2i(hit / game_constants.TILE_SIZE - span2 * rotated) in squares:
		span2 += step
	
	var portal_pos: Vector2 = fix_pos(hit, -normal) # Unfixing the position
	
	if span1 < game_constants.PORTAL_SIZE / 2.0:
		portal_pos += -rotated * (game_constants.PORTAL_SIZE / 2.0 - span1) * game_constants.TILE_SIZE
		
	if span2 < game_constants.PORTAL_SIZE / 2.0:
		portal_pos += rotated * (game_constants.PORTAL_SIZE / 2.0 - span2) * game_constants.TILE_SIZE


	print(portal_pos)

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

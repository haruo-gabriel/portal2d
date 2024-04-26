
class_name PortalCaster
extends Node

var game_constants: GameConstants = load("res://Scripts/Resources/game_constants.tres")

@onready var raycast: RayCast2D = get_parent().get_node("RayCast2D")
@onready var tile_map: TileMap = get_parent().get_parent().get_node("TileMap")
@onready var space_state: PhysicsDirectSpaceState2D = get_parent().get_world_2d().direct_space_state

const DIVISIONS: int = 200
const CASTS: int = 10
const TOLERANCE: float = .9

func to_coord(pos: Vector2) -> Vector2i:
	return Vector2i(pos / game_constants.TILE_SIZE)

func fix_pos(pos: Vector2, normal: Vector2) -> Vector2:
	
	if abs(normal.x) > TOLERANCE: pos.x -= normal.x
	if abs(normal.y) > TOLERANCE: pos.y -= normal.y

	return pos

func is_valid_square(pos: Vector2, normal: Vector2) -> bool:
	
	var query = PhysicsRayQueryParameters2D.create(pos + CASTS * normal, pos - CASTS * normal)
	
	query.exclude = [self]

	var result: Dictionary = space_state.intersect_ray(query)

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

func get_portal() -> Array:
	"""Returns `position` and `normal` of the portal or an empty array if an invalid spot"""

	var hit: Vector2 = raycast.get_collision_point()
	var normal: Vector2 = raycast.get_collision_normal()


	if hit == Vector2.ZERO or hit == null or normal == null:
		return Array()
	

	hit -= tile_map.position
	hit = fix_pos(hit, normal)

	var rotated: Vector2 = normal.rotated(PI / 2)
	var squares: Dictionary = get_valid_squares(hit, normal)


	if len(squares) < game_constants.PORTAL_SIZE:
		return Array()


	var step: float = game_constants.PORTAL_SIZE / DIVISIONS
	
	var span1: float = 0.0
	var span2: float = 0.0

	while Vector2i(hit / game_constants.TILE_SIZE + span1 * rotated) in squares:
		span1 += step

	while Vector2i(hit / game_constants.TILE_SIZE - span2 * rotated) in squares:
		span2 += step
	

	var portal_pos: Vector2 = fix_pos(hit, -normal) # Unfixing the position
	
	if span1 < game_constants.PORTAL_SIZE / 2.0:
		portal_pos += -rotated * (game_constants.PORTAL_SIZE / 2.0 - span1) * game_constants.TILE_SIZE
		
	if span2 < game_constants.PORTAL_SIZE / 2.0:
		portal_pos += rotated * (game_constants.PORTAL_SIZE / 2.0 - span2) * game_constants.TILE_SIZE

	return [portal_pos, normal]

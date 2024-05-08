
class_name PortalCaster
extends Node

@export var player: Player

@onready var raycast: RayCast2D = player.get_node("RayCast2D")
@onready var tile_map: TileMap = player.get_parent().get_node("TileMap")
@onready var space_state: PhysicsDirectSpaceState2D = player.get_world_2d().direct_space_state

# Portal size in pixels
const PORTAL_SIZE_P: float = GameConstants.PORTAL_SIZE * GameConstants.TILE_SIZE

const DIVISIONS: int = 100
const CASTS: int = 10
const TOLERANCE: float = .9

var layer: int
var other_portal: Portal

func to_coord(pos: Vector2) -> Vector2i:

	var x: int = floor(pos[0] / GameConstants.TILE_SIZE)
	var y: int = floor(pos[1] / GameConstants.TILE_SIZE)

	return Vector2i(x, y)

func fix_pos(pos: Vector2, normal: Vector2) -> Vector2:
	return pos - normal

func is_valid_point(pos: Vector2) -> bool:
	
	if tile_map.get_cell_tile_data(layer, to_coord(pos)) == null:
		return false
	
	if other_portal == null:
		return true
	
	return pos.distance_to(other_portal.position) >= PORTAL_SIZE_P / 2

func is_valid_pos(pos: Vector2, normal: Vector2) -> bool:
	
	if not is_valid_point(pos):
		return false

	if not is_valid_point(pos + PORTAL_SIZE_P / 2 * normal.rotated(PI / 2)):
		return false

	if not is_valid_point(pos + PORTAL_SIZE_P / 2 * normal.rotated(-PI / 2)):
		return false

	return true

func get_valid_point(start: Vector2, normal: Vector2, walk_direction: Vector2) -> Vector2:
	
	var step: Vector2 = walk_direction.normalized() * PORTAL_SIZE_P / (DIVISIONS - 1)

	for i in range(DIVISIONS):
		if is_valid_pos(start + step * i, normal):
			return start + step * i
	
	return Vector2.ZERO

func get_portal() -> Array:
	"""Returns `position` and `normal` of the portal or an empty array if an invalid spot"""

	var hit: Vector2 = raycast.get_collision_point()
	var normal: Vector2 = raycast.get_collision_normal()

	if hit == Vector2.ZERO or hit == null or normal == null:
		return Array()
	

	hit -= tile_map.position
	hit -= normal

	var right: Vector2 = get_valid_point(hit, normal, normal.rotated(PI / 2))
	var left: Vector2 = get_valid_point(hit, normal, normal.rotated(-PI / 2))
	
	if not right and not left:
		return []
	
	var portal_pos: Vector2
	
	if right.distance_to(hit) < left.distance_to(hit): portal_pos = right
	else: portal_pos = left
	
	return [portal_pos, normal]

func _ready() -> void:
	
	for i in range(tile_map.get_layers_count()):
		if tile_map.get_layer_name(i) == "Portal":
			layer = i

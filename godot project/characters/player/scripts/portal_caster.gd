
class_name PortalCaster
extends Node

@export var player: Player

@onready var raycast: RayCast2D = player.get_node("RayCast2D")

# Portal size in pixels
const PORTAL_SIZE_P: float = GameConstants.PORTAL_SIZE * GameConstants.TILE_SIZE

const DIVISIONS: int = 100
const CASTS: int = 10
const TOLERANCE: float = .9

var layer: int
var other_portal: Portal

func _to_coord(pos: Vector2) -> Vector2i:

	var x: int = floor(pos[0] / GameConstants.TILE_SIZE)
	var y: int = floor(pos[1] / GameConstants.TILE_SIZE)

	return Vector2i(x, y)

func _is_valid_point(pos: Vector2) -> bool:
	
	if player.tile_map.get_cell_tile_data(layer, _to_coord(pos)) == null:
		return false
	
	if other_portal == null:
		return true
	
	return pos.distance_to(other_portal.position) >= PORTAL_SIZE_P / 2

func _is_valid_pos(pos: Vector2, normal: Vector2) -> bool:
	
	if not _is_valid_point(pos):
		return false

	if not _is_valid_point(pos + PORTAL_SIZE_P / 2 * normal.rotated(PI / 2)):
		return false

	if not _is_valid_point(pos + PORTAL_SIZE_P / 2 * normal.rotated(-PI / 2)):
		return false

	return true

func _get_next_valid_point(start: Vector2, normal: Vector2, walk_direction: Vector2) -> Vector2:
	
	var step: Vector2 = walk_direction.normalized() * PORTAL_SIZE_P / (DIVISIONS - 1)

	for i in range(DIVISIONS):
		if _is_valid_pos(start + step * i, normal):
			return start + step * i
	
	return Vector2.ZERO

func get_portal(type: PortalsConstants.PortalType) -> Array:
	"""Returns `position` and `normal` of the portal or an empty array if an invalid spot"""

	raycast.target_position = 1000 * Vector2(cos(player.angle), sin(player.angle))

	var hit: Vector2 = raycast.get_collision_point()
	var normal: Vector2 = raycast.get_collision_normal()

	if hit == Vector2.ZERO or hit == null or normal == null:
		return Array()
	
	for child in player.tile_map.get_tree().get_nodes_in_group("Portal"):
		if child.type != type:
			other_portal = child

	hit -= player.tile_map.position
	hit -= normal

	if not _is_valid_point(hit):
		return []

	var right: Vector2 = _get_next_valid_point(hit, normal, normal.rotated(PI / 2))
	var left: Vector2 = _get_next_valid_point(hit, normal, normal.rotated(-PI / 2))
	
	other_portal = null
	
	if not right and not left:
		return []
	
	var portal_pos: Vector2
	
	if right.distance_to(hit) < left.distance_to(hit): portal_pos = right
	else: portal_pos = left
	
	return [portal_pos + normal, normal]

func _ready() -> void:
	
	for i in range(player.tile_map.get_layers_count()):
		if player.tile_map.get_layer_name(i) == "Portal":
			layer = i

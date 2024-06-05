
class_name FollowCam
extends Camera2D

@export var tile_map: TileMap


func _ready() -> void:
	
	var rect: Rect2i = tile_map.get_used_rect()
	var tile_size: int = tile_map.rendering_quadrant_size
	
	var top_left: Vector2i = rect.position * tile_size

	limit_left = top_left.x
	limit_top = top_left.y
	
	limit_right = limit_left + rect.size.x * tile_size
	limit_bottom = limit_top + rect.size.y * tile_size
	

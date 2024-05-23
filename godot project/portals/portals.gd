
extends Node

var PORTAL_SCENE: Resource = preload("res://portals/common/portal.tscn")

var portal_map: Dictionary = {
	PortalsConstants.PortalType.PORTAL_TYPE_ORANGE: null,
	PortalsConstants.PortalType.PORTAL_TYPE_BLUE: null
}

func create_portal_instance(type: PortalsConstants.PortalType, position: Vector2, normal: Vector2) -> void:

	if portal_map[type] != null:
		remove_portal(type)

	var new_portal: Portal = PORTAL_SCENE.instantiate()

	new_portal.modulate = PortalsConstants.PORTAL_COLORS[type]

	new_portal.type = type
	new_portal.position = position
	new_portal.normal = normal
	new_portal.rotation = normal.angle()

	portal_map[type] = new_portal
	
	add_child(new_portal)


func remove_portal(type: PortalsConstants.PortalType) -> void:
	# If Portal is already instantiated, uninstantiate it
	portal_map[type].queue_free()
	portal_map[type] = null

func can_teleport(body: PhysicsBody2D, velocity: Vector2) -> PortalsConstants.PortalType:
	
	var original_mask: int = body.collision_mask
	
	body.collision_mask = 2

	var collision: KinematicCollision2D = body.move_and_collide(velocity, true)

	body.collision_mask = original_mask
	
	if collision == null:
		return -1

	if collision.get_collider_shape() == null:
		return -1
	
	var shape: CollisionShape2D = collision.get_collider_shape()
	
	if not shape.is_in_group("teleport_area"):
		return -1

	var portal: Portal = shape.get_parent()
	var other_portal: Portal = portal_map[1 - portal.type]
	
	if other_portal == null:
		return -1
	
	return portal.type

func try_teleport(body: PhysicsBody2D, velocity: Vector2) -> void:
	
	var portal_type: int = -1

	if portal_type < 0: 
		portal_type = can_teleport(body, velocity)

	if portal_type < 0: 
		portal_type = can_teleport(body, Vector2(velocity.x, velocity.y + 10))
	
	if portal_type < 0: 
		portal_type = can_teleport(body, Vector2(velocity.x, velocity.y - 10))

	if portal_type >= 0:

		var portal: Portal = Portals.portal_map[portal_type]
		var other: Portal = Portals.portal_map[1 - portal_type]
	
		portal._teleport_object(body, other)

#(0, -1) = U
#(0, 1) = D
#(-1, 0) = L
#(1, 0) = R


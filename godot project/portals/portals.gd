
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


func try_teleport(body: PhysicsBody2D, velocity: Vector2) -> void:
	
	var original_mask: int = body.collision_mask
	
	body.collision_mask = 2

	var collision: KinematicCollision2D = body.move_and_collide(velocity, true)

	body.collision_mask = original_mask
	
	if collision == null:
		return

	if collision.get_collider_shape() == null:
		return
	
	var shape: CollisionShape2D = collision.get_collider_shape()
	
	if not shape.is_in_group("teleport_area"):
		return

	var portal: Portal = shape.get_parent()
	var other_portal: Portal = portal_map[1 - portal.type]
	
	if other_portal == null:
		return
	
	portal._teleport_object(body, other_portal)

#(0, -1) = U
#(0, 1) = D
#(-1, 0) = L
#(1, 0) = R


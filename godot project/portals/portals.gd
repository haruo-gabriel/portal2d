
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

#(0, -1) = U
#(0, 1) = D
#(-1, 0) = L
#(1, 0) = R


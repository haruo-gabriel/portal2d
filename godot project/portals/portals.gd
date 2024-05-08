
extends Node

var portal_map: Dictionary = {
	PortalsConstants.PortalType.PORTAL_TYPE_ORANGE: null,
	PortalsConstants.PortalType.PORTAL_TYPE_BLUE: null
}


func create_portal_instance(type: PortalsConstants.PortalType, position, normal):
	if portal_map[type] != null:
		remove_portal(type)

	# If Portal is not instantiated, instantiate it at the correct position
	if type == PortalsConstants.PortalType.PORTAL_TYPE_BLUE:
		var portal_scene = preload("res://portals/blue_portal.tscn")
		var new_portal: Portal = portal_scene.instantiate()
		new_portal.type = PortalsConstants.PortalType.PORTAL_TYPE_BLUE
		new_portal.position = position
		new_portal.normal = normal
		new_portal.rotate(normal.angle())


		portal_map[PortalsConstants.PortalType.PORTAL_TYPE_BLUE] = new_portal		
		add_child(new_portal)
	else:
		var portal_scene = preload("res://portals/orange_portal.tscn")
		var new_portal: Portal = portal_scene.instantiate()
		new_portal.type = PortalsConstants.PortalType.PORTAL_TYPE_ORANGE
		new_portal.position = position
		new_portal.normal = normal
		new_portal.rotate(normal.angle())
		
		portal_map[PortalsConstants.PortalType.PORTAL_TYPE_ORANGE] = new_portal		
		add_child(new_portal)
		

func remove_portal(type: PortalsConstants.PortalType):
	# If Portal is already instantiated, uninstantiate it
	portal_map[type].queue_free()
	portal_map[type] = null

#(0, -1) = U
#(0, 1) = D
#(-1, 0) = L
#(1, 0) = R


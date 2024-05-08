
class_name Portal
extends Area2D

var type: PortalsConstants.PortalType  
var direction: float = 0.0
var normal: Vector2

const _POSITION_OFFSET_CONSTANT = Vector2(5, 5)  

func _get_other_portal() -> Portal:
	if type == PortalsConstants.PortalType.PORTAL_TYPE_BLUE:
		return Portals.portal_map[PortalsConstants.PortalType.PORTAL_TYPE_ORANGE]
	else:
		return Portals.portal_map[PortalsConstants.PortalType.PORTAL_TYPE_BLUE]

func _get_new_body_position(body: CollisionObject2D, otherPortal: Portal) -> Vector2:
	# Get object dimentions
	var object_shape = body.get_enabled_hitbox().shape.extents
	var offset = otherPortal.normal * (object_shape + _POSITION_OFFSET_CONSTANT)
	return otherPortal.position + offset
		
func _get_new_body_velocity(body: CollisionObject2D, otherPortal: Portal) -> Vector2:
	var relativeVelocity = body.velocity.rotated(normal.angle_to(otherPortal.normal))
	return relativeVelocity.rotated(direction - otherPortal.direction + PI)
	
func _teleport_object(body: CollisionObject2D, otherPortal: Portal):
		body.position = _get_new_body_position(body, otherPortal)
		body.velocity = _get_new_body_velocity(body, otherPortal)


func _on_body_entered(body):
	var otherPortal: Portal = _get_other_portal()
	
	if body.is_in_group("Teleportable"):
		if otherPortal == null:
			print("There is only one portal")
			return
		
		_teleport_object(body, otherPortal)

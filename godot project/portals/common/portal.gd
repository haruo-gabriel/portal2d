
class_name Portal
extends StaticBody2D

var type: PortalsConstants.PortalType
var direction: float = 0.0
var normal: Vector2

const _POSITION_OFFSET_CONSTANT = Vector2(5, 5)  

func _get_other_portal() -> Portal:
	return Portals.portal_map[1 - type]

func _get_new_body_position(body: CollisionObject2D, otherPortal: Portal) -> Vector2:
	# Get object dimentions
	var object_shape = body.get_enabled_hitbox().shape.extents
	var offset = otherPortal.normal * (object_shape + _POSITION_OFFSET_CONSTANT)

	return otherPortal.position + offset

func _get_new_body_velocity(body: CollisionObject2D, otherPortal: Portal) -> Vector2:

	var relativeVelocity = body.velocity.rotated(normal.angle_to(otherPortal.normal))

	return relativeVelocity.rotated(direction - otherPortal.direction + PI)
	
func _teleport_object(body: CollisionObject2D, otherPortal: Portal) -> void:

	body.position = _get_new_body_position(body, otherPortal)
	body.velocity = _get_new_body_velocity(body, otherPortal)

func _on_body_entered(body: Node2D) -> void:

	var otherPortal: Portal = _get_other_portal()

	_teleport_object(body, otherPortal)

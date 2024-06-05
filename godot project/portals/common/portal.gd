
class_name Portal
extends StaticBody2D

var type: PortalsConstants.PortalType
var direction: float = 0.0
var normal: Vector2

var cooldown: int = 0

const _TELEPORT_COOLDOWN: int = 10
const _POSITION_OFFSET_CONSTANT: Vector2 = Vector2(5, 5)

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
	
func _teleport_object(body: PhysicsBody2D, otherPortal: Portal) -> void:

	if cooldown:
		return
	
	otherPortal.cooldown = _TELEPORT_COOLDOWN

	body.position = _get_new_body_position(body, otherPortal)

	var new_mag: float = body.velocity.project(normal).length()

	new_mag = new_mag * .7

	body.velocity = new_mag * otherPortal.normal

	# body.velocity = _get_new_body_velocity(body, otherPortal)

func _physics_process(_delta: float) -> void:
	
	if cooldown:
		cooldown -= 1

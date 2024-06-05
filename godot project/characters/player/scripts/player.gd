
class_name Player
extends CharacterBody2D

@export var tile_map: TileMap

@onready var main_hitbox: CollisionShape2D = $MainHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

@onready var raycast: RayCast2D = $RayCast2D
@onready var portal_caster: PortalCaster = $PortalCaster

@onready var health: Health = $Health

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

# SFX resourcesv variables
@onready var portal_gunshot_sfx = $PortalGunshotSFX
@onready var hit_taken_sfx = $HitTakenSFX

var direction: float = 0.0
var angle: float = 0.0

var last_jumped: int = 0
var jumped: bool = false

var is_falling: bool = false
var is_crouching: bool = false

func shoot(type: PortalsConstants.PortalType) -> void:
	
	var result: Array = portal_caster.get_portal(type)

	if not result:
		return

	var _pos: Vector2 = result[0]
	var _normal: Vector2 = result[1]
		
	Portals.create_portal_instance(type, _pos, _normal)

func set_angle() -> void:
	
	var difference: Vector2 = get_global_mouse_position() - raycast.global_position

	if difference: 
		angle = atan2(difference.y, difference.x)

	raycast.target_position = 1000 * Vector2(cos(angle), sin(angle))

func get_enabled_hitbox() -> CollisionShape2D:
	
	if main_hitbox.disabled:
		return crouched_hitbox
	
	return main_hitbox

func toggle_hitbox(to_crouch: bool) -> void:

	main_hitbox.disabled = to_crouch
	crouched_hitbox.disabled = not to_crouch

	is_crouching = to_crouch

func toggle_crouch(to_crouch: bool) -> void:

	toggle_hitbox(to_crouch)

	# We want it to not collide with anything after changin the hitbox
	if move_and_collide(Vector2.ZERO, true):
		toggle_hitbox(not to_crouch)

func try_jump() -> void:
	
	if Input.is_action_just_pressed("jump"):
		last_jumped = PlayerConstants.JUMP_BUFFER_TIME

	if last_jumped and is_on_floor():
		last_jumped = 0
		jumped = true
	else:
		jumped = false

	last_jumped = max(0, last_jumped - 1)

func move() -> void:
	
	try_jump()

	velocity.x = clamp(velocity.x, -PlayerConstants.MAX_X_SPEED, PlayerConstants.MAX_X_SPEED)
	velocity.y = clamp(velocity.y, -PlayerConstants.MAX_Y_SPEED, PlayerConstants.MAX_Y_SPEED)

func get_test_speed(delta: float) -> Vector2:
	
	var test_speed: Vector2 = 2 * velocity * delta
	
	var down: Vector2 = floor(test_speed)
	var up: Vector2 = ceil(test_speed)
	
	test_speed.x = down.x if abs(down.x) > abs(up.x) else up.x
	test_speed.y = down.y if abs(down.y) > abs(up.y) else up.y
	
	if direction > 0:
		test_speed.x = max(test_speed.x, direction)
		
	if direction < 0:
		test_speed.x = min(test_speed.x, direction)
	
	return test_speed

func _process(_delta: float) -> void:

	direction = Input.get_axis("move_left", "move_right")

	var try_crouch = Input.is_action_pressed("crouch")

	if try_crouch and not is_crouching:
		toggle_crouch(true)
	
	if not try_crouch and is_crouching:
		toggle_crouch(false)

	if Input.is_action_just_pressed("shoot_portal1"):
		shoot(PortalsConstants.PortalType.PORTAL_TYPE_BLUE)
		portal_gunshot_sfx.play()
		
	if Input.is_action_just_pressed("shoot_portal2"):
		shoot(PortalsConstants.PortalType.PORTAL_TYPE_ORANGE)
		portal_gunshot_sfx.play()
	
	set_angle()

func _physics_process(delta: float) -> void:
	
	move()

	Portals.try_teleport(self, get_test_speed(delta))
	
	move_and_slide()


func _on_laser_hit(laser: Laser) -> void:

	health.take_damage(2)

	position += laser.velocity * laser.mass / 2000
	velocity += laser.velocity * laser.mass / 2000
	
	hit_taken_sfx.play()

	laser.queue_free()


func player_death():
	
	Portals.clear()
	
	get_tree().reload_current_scene()

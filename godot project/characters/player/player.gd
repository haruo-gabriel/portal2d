
class_name Player
extends CharacterBody2D

@export var stats: PlayerStats

@export var constants: PlayerConstants
@export var game_constants: GameConstants

@onready var main_hitbox: CollisionShape2D = $MainHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

@onready var raycast: RayCast2D = $RayCast2D
@onready var portal_caster: PortalCaster = $PortalCaster

@onready var health: Health = $Health

var direction: float = 0.0
var angle: float = 0.0

var last_jumped: int = 0
var jumped: bool = false

var is_falling: bool = false
var is_crouching: bool = false

func shoot() -> void:
	
	var result: Array = portal_caster.get_portal()

	if not result:
		return

	var pos: Vector2 = result[0]
	var normal: Vector2 = result[1]
	
	# TODO: Add the portal creation

func set_angle() -> void:
	
	var difference: Vector2 = get_global_mouse_position() - raycast.global_position

	if difference: 
		angle = atan2(difference.y, difference.x)

func toggle_hitbox(to_crouch: bool) -> void:

	main_hitbox.disabled = to_crouch
	crouched_hitbox.disabled =  not to_crouch

	is_crouching = to_crouch

func toggle_crouch(to_crouch: bool) -> void:

	toggle_hitbox(to_crouch)

	# We want it to not collide with anything after changin the hitbox
	if move_and_collide(Vector2.ZERO, true):
		toggle_hitbox(not to_crouch)

func try_jump() -> void:
	
	if Input.is_action_just_pressed("jump"):
		last_jumped = constants.JUMP_BUFFER_TIME

	if last_jumped and is_on_floor():
		last_jumped = 0
		jumped = true
	else:
		jumped = false

	last_jumped = max(0, last_jumped - 1)

func move() -> void:
	
	try_jump()

	velocity.x = clamp(velocity.x, -constants.MAX_X_SPEED, constants.MAX_X_SPEED)
	velocity.y = clamp(velocity.y, -constants.MAX_Y_SPEED, constants.MAX_Y_SPEED)

	move_and_slide()

func _process(_delta: float) -> void:

	direction = Input.get_axis("move_left", "move_right")

	var try_crouch = Input.is_action_pressed("crouch")

	if try_crouch and not is_crouching:
		toggle_crouch(true)
	
	if not try_crouch and is_crouching:
		toggle_crouch(false)

	if Input.is_action_just_pressed("shoot_portal1"):
		shoot()

	set_angle()

func _physics_process(_delta: float) -> void:
	move()

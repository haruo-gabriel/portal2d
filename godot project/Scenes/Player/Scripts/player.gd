
extends CharacterBody2D

@onready var stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

@onready var main_hitbox: CollisionShape2D = $NormalHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

@onready var sprite: Sprite2D = $PlayerSprite
@onready var animation: AnimationPlayer = $AnimationPlayer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var last_jumped: int # Frames since last jump input

var sprite_crouching_offset: Vector2 # Is constant and set at start

signal jumped

func set_stats() -> void:

	stats.position = position
	stats.velocity = velocity

func set_angle() -> void:
	
	var difference: Vector2 = get_global_mouse_position() - global_position

	if difference: 
		stats.angle = atan2(difference.y, difference.x)

func set_hitbox() -> void:
	
	main_hitbox.disabled = stats.is_crouching
	crouched_hitbox.disabled = not stats.is_crouching

func crouch() -> void:
	
	main_hitbox.disabled = true
	crouched_hitbox.disabled = false
	
	stats.is_crouching = true	
	sprite.offset = sprite_crouching_offset

func uncrouch() -> void:
	
	# We want it to not collide with anything when undoing the hitbox change
	if move_and_collide(-sprite_crouching_offset, true) != null:
		return
	
	main_hitbox.disabled = false
	crouched_hitbox.disabled = true
	
	stats.is_crouching = false

	sprite.offset = Vector2.ZERO

func jump() -> void:

	velocity.y = constants.JUMP_VELOCITY

	velocity.x *= constants.BHOP_MULTIPLIER

	jumped.emit()

func move_vertical(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		last_jumped = constants.JUMP_BUFFER_TIME

	if last_jumped and is_on_floor():
		last_jumped = 0
		jump()

	if not is_on_floor():
		velocity.y += gravity * delta

	if last_jumped > 0:
		last_jumped -= 1

func move_horizontal(_delta: float) -> void:

	# TODO: make this not so ulgy

	if stats.direction:
		
		var step = constants.HORIZONTAL_ACCELERATION
		var new_speed = stats.direction * constants.WALKING_SPEED
		
		# You won't be slowed while on air
		if stats.is_crouching and is_on_floor():
			new_speed *= constants.CROUCH_SPEED_MULTIPLIER
			
		if not is_on_floor():
			
			step *= constants.IN_AIR_MULTIPLIER
			
			# If you're going foward, you won't deaccelerate.
			# If you wanna go backward, you still can.
			if sign(velocity.x) == sign(stats.direction):
				new_speed = sign(new_speed) * max(abs(new_speed), abs(velocity.x))
		
		velocity.x = move_toward(velocity.x, new_speed, step)	

	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, constants.GROUND_DRAG)

func move(delta: float) -> void:
	
	move_horizontal(delta)
	move_vertical(delta)
	
	# Ensures velocity is within bounds
	velocity.x = max(-constants.MAX_X_SPEED, min(constants.MAX_X_SPEED, velocity.x))
	velocity.y = max(-constants.MAX_Y_SPEED, min(constants.MAX_Y_SPEED, velocity.y))

func _ready() -> void:
	
	last_jumped = 0
	
	main_hitbox.disabled = false
	crouched_hitbox.disabled = true

	sprite_crouching_offset = main_hitbox.shape.get_rect().size - crouched_hitbox.shape.get_rect().size

func _physics_process(delta: float) -> void:

	stats.is_on_floor = is_on_floor()

	stats.direction = Input.get_axis("move_left", "move_right")
	var try_crouch = Input.is_action_pressed("crouch")

	if try_crouch and not stats.is_crouching:
		crouch()
	
	if not try_crouch and stats.is_crouching:
		uncrouch()

	move(delta)

	set_hitbox()
	set_angle()
	set_stats()

	move_and_slide()
	
	animation.set_animation()

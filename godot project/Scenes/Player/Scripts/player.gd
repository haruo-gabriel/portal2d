
class_name Player
extends CharacterBody2D


@onready var stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")
@onready var constants: PlayerConstants = load("res://Scenes/Player/player_constants.tres")

@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var main_hitbox: CollisionShape2D = $MainHitbox
@onready var crouched_hitbox: CollisionShape2D = $CrouchedHitbox

func set_stats() -> void:

	position = stats.position
	velocity = stats.velocity

func set_angle() -> void:
	
	var difference: Vector2 = get_global_mouse_position() - (global_position + constants.PLAYER_CENTER)

	if difference: 
		stats.angle = atan2(difference.y, difference.x)

func toggle_hitbox(to_crouch: bool) -> void:

	main_hitbox.disabled = to_crouch
	crouched_hitbox.disabled =  not to_crouch

	stats.is_crouching = to_crouch

func toggle_crouch(to_crouch: bool) -> void:

	toggle_hitbox(to_crouch)

	# We want it to not collide with anything after changin the hitbox
	if move_and_collide(Vector2.ZERO, true):
		toggle_hitbox(not to_crouch)


func move_vertical(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		stats.last_jumped = constants.JUMP_BUFFER_TIME

	if stats.last_jumped and stats.is_on_floor:
		stats.last_jumped = 0
		stats.jumped = true
	else:
		stats.jumped = false

	stats.last_jumped = max(0, stats.last_jumped - 1)

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

	velocity.x = clamp(velocity.x, -constants.MAX_X_SPEED, constants.MAX_X_SPEED)
	velocity.y = clamp(velocity.y, -constants.MAX_Y_SPEED, constants.MAX_Y_SPEED)

func _ready() -> void:
	
	stats.position = position
	stats.velocity = velocity

func _physics_process(delta: float) -> void:

	stats.is_on_floor = is_on_floor()
	stats.direction = Input.get_axis("move_left", "move_right")

	var try_crouch = Input.is_action_pressed("crouch")

	if try_crouch and not stats.is_crouching:
		toggle_crouch(true)
	
	if not try_crouch and stats.is_crouching:
		toggle_crouch(false)

	move_vertical(delta)
	# move(delta)

	set_angle()
	set_stats()

	# animation.set_animation()

	move_and_slide()

	stats.position = position
	stats.velocity = velocity


extends CharacterBody2D

const WALKING_SPEED: float = 300.0
const HORIZONTAL_ACCELERATION: float = 20.0 # Pixels per second per frame

const GROUND_DRAG: float = 15.0 # Deacceleration on ground.

# It's harder to change direction while on air
const IN_AIR_MULTIPLIER: float = .3

# Multiplies your speed upon jumping.
# Set it to 1 to remove it.
const BHOP_MULTIPLIER: float = 1.2

const JUMP_VELOCITY: float = -600.0

const MAX_Y_SPEED: float = 1000.0 # In absolute value
const MAX_X_SPEED: float = 600.0 # In absolute value

# Frames a player can press jump before landing and still jump upon hitting ground.
# To remove, set it to 1, NOT ZERO (the player won't be able to jump).
const JUMP_BUFFER_TIME: int = 10

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: float
var last_jumped: int = 0 # Frames since last jump input

func set_animation() -> void:
	"""
	Sets the animation for the player, according to it's 
	direction and vertical speed.
	"""
	
	# animation.play("Jump") is called in `jump`
	# adding it here with a `velocity < 0` check would make the 
	# animation restart while the player is in the air
	
	if velocity.y > 0:
		animation.play("Fall")

	# Return eaarly if the player is in the air or about to jump	
	if velocity.y:
		return
	
	if not velocity.x:
		animation.play("Idle")
	else:
		animation.play("Walk")

func set_sprite() -> void:
	
	# We don't flip if we aren't moving
	if not direction: 
		return
	
	sprite.flip_h = direction < 0

func jump() -> void:

	velocity.y = JUMP_VELOCITY

	velocity.x *= BHOP_MULTIPLIER

	animation.play("Jump")

func move_vertical(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		last_jumped = JUMP_BUFFER_TIME

	if last_jumped and is_on_floor():
		last_jumped = 0
		jump()

	if not is_on_floor():
		velocity.y += gravity * delta

	# Ensures velocity.y is within bounds
	velocity.y = min(MAX_Y_SPEED, max(-MAX_Y_SPEED, velocity.y))

	if last_jumped > 0:
		last_jumped -= 1

func move_horizontal(delta: float) -> void:

	if direction:
		
		var step = HORIZONTAL_ACCELERATION
		var new_speed = direction * WALKING_SPEED
		
		if not is_on_floor():
			
			step *= IN_AIR_MULTIPLIER
			
			# You don't deaccelerate while on air
			new_speed = max(new_speed, velocity.x)
		
		velocity.x = move_toward(velocity.x, new_speed, step)	

	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, GROUND_DRAG)

	# Ensures velocity.x is within bounds
	velocity.x = max(-MAX_X_SPEED, min(MAX_X_SPEED, velocity.x))

func _physics_process(delta: float) -> void:

	direction = Input.get_axis("move_left", "move_right")

	move_vertical(delta) # This should go before `move_horizontal`, due to bhop
	move_horizontal(delta)

	set_animation()
	set_sprite()

	move_and_slide()

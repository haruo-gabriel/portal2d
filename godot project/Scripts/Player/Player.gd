
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0 / 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 8

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var direction: float
var jumped: bool

func set_animation() -> void:
	"""
	Sets the animation for the player, according to it's 
	direction and vertical speed.
	"""
	
	# animation.play("Jump") is called in `jump`
	# adding it here with a `velocity < 0` check would make the 
	# animation restart while the player is in the air
	
	if velocity.y > 0:
		return animation.play("Fall") # Returns early so others don't affect it
	
	if not is_on_floor():
		return
	
	# This part should only be reached
	# if the player is on the ground.
	
	if not direction:
		animation.play("Idle")
	else:
		animation.play("Walk")


func jump() -> void:

	velocity.y = JUMP_VELOCITY
	
	animation.play("Jump")


func _physics_process(delta: float) -> void:

	direction = Input.get_axis("move_left", "move_right")
	jumped = Input.is_action_just_pressed("jump") and is_on_floor()

	set_animation()
	
	if jumped:
		jump()

	if not is_on_floor():
		velocity.y += gravity * delta

	
	if direction < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

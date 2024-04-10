
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var direction: float

func set_animation() -> void:
	"""
	Sets the animation for the player, according to it's 
	direction and vertical speed.
	"""
	
	if velocity.y > 0:
		return animation.play("Fall") # Returns early so others don't affect it
	elif velocity.y < 0:
		return animation.play("Jump")

	# This part should only be reached
	# if the player is on the ground.
	
	if not direction:
		animation.play("Idle")
	else:
		animation.play("Walk")
	
	
func _physics_process(delta: float) -> void:

	direction = Input.get_axis("move_left", "move_right")

	set_animation()

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

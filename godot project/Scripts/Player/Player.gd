
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("move_left", "move_right")

	if not direction and is_on_floor():
		animation.play("Idle")
	elif is_on_floor():
		animation.play("Walk")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		animation.play("Jump")
		velocity.y = JUMP_VELOCITY

	if velocity.y > 0:
		animation.play("Fall")

	if direction < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

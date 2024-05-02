
extends Node

const WALKING_SPEED: float = 100.0
const HORIZONTAL_ACCELERATION: float = 10.0 # Pixels per second per frame

const GROUND_DRAG: float = 6.0 # Deacceleration on ground.

# It's harder to change direction while on air
const IN_AIR_MULTIPLIER: float = .3

# Multiplies your speed upon jumping.
# Set it to 1 to remove it.
const BHOP_MULTIPLIER: float = 1.2

# You move slower while crouched
const CROUCH_SPEED_MULTIPLIER: float = .5

const JUMP_VELOCITY: float = -200.0

const MAX_Y_SPEED: float = 400.0 # In absolute value
const MAX_X_SPEED: float = 300.0 # In absolute value

# Frames a player can press jump before landing and still jump upon hitting ground.
# To remove, set it to 1, NOT ZERO (the player won't be able to jump).
const JUMP_BUFFER_TIME: int = 10


const MAX_HP: float = 100.0
const REGENERATION: float = 1.0

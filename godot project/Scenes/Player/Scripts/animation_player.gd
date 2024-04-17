
extends AnimationPlayer

@onready var player_stats: PlayerStats = load("res://Scenes/Player/player_stats.tres")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:

	# animation.play("Jump") is called in `jump`
	# adding it here with a `velocity < 0` check would make the 
	# animation restart while the player is in the air
	
	if player_stats.is_crouching:

		# While on air and crouching, we play the idle animation.
		# I'm taking this from Mario, as it seems like too much work
		# to add a bunch of sprites for this very specific case.
		if not player_stats.velocity.x or not player_stats.is_on_floor:
			play("Idle (Crouched)")
	
		else:
			play("Walk (Crouched)")

		return
	
	if player_stats.velocity.y > 0:
		play("Fall")

	# Return eaarly if the player is in the air or about to jump	
	if player_stats.velocity.y:
		return
	
	if not player_stats.velocity.x:
		play("Idle")
	else:
		play("Walk")


func _on_player_jumped() -> void:
	
	if not player_stats.is_crouching:
		play("Jump")

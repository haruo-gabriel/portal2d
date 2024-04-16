extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	var player_start = Vector2(240, 450)
	$Player.start(player_start)
	var portal_start = Vector2(200, 400)
	$Portal.start(portal_start)
	


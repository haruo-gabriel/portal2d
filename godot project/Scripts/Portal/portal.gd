extends Area2D

var otherPortal = null
var isLocked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for portal in get_tree().get_nodes_in_group("Portal"):
		if portal.name != name:
			otherPortal = portal
	if otherPortal == null:
		# todo portal doesn't exist yet (or was not placed)
		print("There is only one portal")

func lock() -> void:
	isLocked = true

func unlock() -> void:
	isLocked = false

func _on_body_entered(body):
	if isLocked:
		return
	lock()
	body.position = otherPortal.position

	
func _on_body_exited(body):
	unlock()


func start(pos):
	pass




extends Node2D


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		%HUD.visible = false
		%Pause.visible = true
		get_tree().paused = true

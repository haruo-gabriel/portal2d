extends Control



func _on_continue_button_pressed():
	get_tree().paused = false
	visible = false


func _on_quit_button_pressed():
	get_tree().quit()

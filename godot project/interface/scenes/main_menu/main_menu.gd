extends Control


@export var new_game_scene: PackedScene
#@export var credits_scene: PackedScene
@export var menu_music: AudioStreamPlayer


func _ready() -> void:
	await AudioManager.fade_in(menu_music, 4.0, true)


func _on_new_game_button_pressed():
	AudioManager.fade_out(menu_music, 1.0)
	$ScreenTransition.transition(new_game_scene)


func _on_exit_button_pressed():
	get_tree().quit()


#func _on_credits_button_pressed():
	#AudioManager.fade_out(menu_music, 1.0)
	#$ScreenTransition.transition(credits_scene)

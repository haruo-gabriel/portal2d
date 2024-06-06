extends Control


@export var new_game_scene: PackedScene
@export var credits_scene: PackedScene

func _ready() -> void:
	AudioManager.fade_in($MainMenuMusic, 4.0, true)

func _on_new_game_button_pressed():
	await AudioManager.fade_out($MainMenuMusic, 1.0)
	$ScreenTransition.transition(new_game_scene)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	$ScreenTransition.transition(credits_scene)

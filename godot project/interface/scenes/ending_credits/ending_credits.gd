extends Control


@export var target_scene: PackedScene
@export var menu_music: AudioStreamPlayer


func _ready() -> void:
	await AudioManager.fade_in(menu_music, 3.0, true)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(target_scene)
	await AudioManager.fade_out(menu_music, 1.0)
	$ScreenTransition.transition(target_scene)
	get_tree().quit()

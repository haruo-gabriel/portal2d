extends CanvasLayer

@export var target_scene: PackedScene


func transition(target: PackedScene = target_scene):
	$AnimationPlayer.play_backwards("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)

extends Control

@export var default_screen_time := 6.0
@export var fade_duration := 2.0


func _ready():
	for frame: Control in get_children():
		frame.modulate.a = 0.0
	
	for frame: Control in get_children():
		await fade_frame(frame, 1.0, fade_duration)
		await get_tree().create_timer(default_screen_time).timeout
		await fade_frame(frame, 0.0, fade_duration)


func fade_frame(frame: Control, final_alpha: float, duraton: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(frame, "modulate", Color(1, 1, 1, final_alpha), duraton)
	tween.play()
	await tween.finished
	return

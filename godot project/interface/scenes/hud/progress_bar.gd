
extends ProgressBar

var player: Player

func _process(delta: float) -> void:

	max_value = player.health.max_health
	value = player.health.health

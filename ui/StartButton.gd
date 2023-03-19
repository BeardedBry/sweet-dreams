extends Button

onready var music: AudioStreamPlayer = $BGMusic


func _on_StartButton_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")

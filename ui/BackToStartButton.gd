extends Button


func _on_BackToStartButton_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/StartScreen.tscn")

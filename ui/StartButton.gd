extends Button


func _on_StartButton_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")


func _on_HelpButton_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/Help.tscn")

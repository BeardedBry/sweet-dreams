extends Node2D

onready var y_sort = $YSort
onready var health_progress = $HealthBar/HealthProgress
var _increment_timer = Timer.new()
var _health = 100


func _ready() -> void:
	health_progress.value = _health
	# Timer setup.
	_increment_timer.connect("timeout", self, "_increment")
	_increment_timer.wait_time = .1
	_increment_timer.one_shot = false
	add_child(_increment_timer)
	_increment_timer.start()


func _increment() -> void:
	for child in y_sort.get_children():
		if child.has_method("wake"):
			var stage = child.wake()
			if stage in [Globals.SleepStage.AWAKE, Globals.SleepStage.DEAD]:
				_health -= 1
		health_progress.value = _health
		if _health <= 0:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://ui/GameOver.tscn")

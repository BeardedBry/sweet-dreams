extends Node2D

onready var y_sort = $YSort
var _increment_timer = Timer.new()
var _health = 100


func _ready() -> void:
	# Timer setup.
	_increment_timer.connect("timeout", self, "_increment")
	_increment_timer.wait_time = 2.0
	_increment_timer.one_shot = false
	add_child(_increment_timer)
	_increment_timer.start()


func _increment() -> void:
	for child in y_sort.get_children():
		if child.has_method("wake"):
			var stage = child.wake()
			if stage in [Globals.SleepStage.AWAKE, Globals.SleepStage.DEAD]:
				_health -= 1

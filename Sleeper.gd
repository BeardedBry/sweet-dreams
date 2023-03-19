extends StaticBody2D

export var sleeper: int = 0
onready var _sprite: Sprite = $Sprite

var wake_increment: float = 0.1
var max_sleep_health: float = 2
var _stage = Globals.SleepStage.MEDIUM
var _sleep_health: float = 1


func _ready() -> void:
	_sprite.frame = sleeper


func bonk(damage: int = 1) -> void:
	if _stage == Globals.SleepStage.DEAD:
		return
	elif _stage == Globals.SleepStage.HEAVY:
		_stage = Globals.SleepStage.DEAD
		_update_stage(0)
	_sleep_health -= damage
	max_sleep_health += 0.1
	if _sleep_health <= 0:
		_update_stage(1)


func wake() -> int:
	_sleep_health += wake_increment
	print("%s: %s" % [_stage, _sleep_health])
	if _sleep_health >= max_sleep_health:
		_update_stage(-1)
	return _stage


func _update_stage(amount: int) -> void:
	if _stage == Globals.SleepStage.AWAKE and amount <= 0:
		return
	elif _stage == Globals.SleepStage.DEAD:
		return
	_stage += amount
	_sleep_health = max_sleep_health / 2.0
	if _stage == Globals.SleepStage.AWAKE:
		pass
	elif _stage == Globals.SleepStage.LIGHT:
		pass
	elif _stage == Globals.SleepStage.MEDIUM:
		pass
	elif _stage == Globals.SleepStage.HEAVY:
		pass
	elif _stage == Globals.SleepStage.DEAD:
		pass

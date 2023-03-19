extends StaticBody2D

export var sleeper: int = 0
export var sleep_stage: int = 0
export var manual_sleep_stage: bool = false

onready var _bed_sprite: Sprite = $BedSprite
onready var _bubble_sprite: Sprite = $BubbleSprite

var wake_increment: float = 0.1
var max_sleep_health: float = 2.0
var _stage = Globals.SleepStage.MEDIUM
var _sleep_health: float = 1.0
var _damage: float = 1.0


func _ready() -> void:
	_bed_sprite.frame = sleeper
	if manual_sleep_stage:
		_bubble_sprite.frame = sleep_stage
	else:
		_update_stage(0)
	var random = RandomNumberGenerator.new()
	random.randomize()
	_sleep_health += random.randf()


func bonk() -> void:
	if _stage == Globals.SleepStage.DEAD:
		return
	elif _stage == Globals.SleepStage.HEAVY:
		_stage = Globals.SleepStage.DEAD
		_update_stage(0)
	_sleep_health -= _damage
	_damage *= 0.9
	max_sleep_health += 0.1
	if _sleep_health <= 0:
		_update_stage(1)


func wake() -> int:
	_sleep_health += wake_increment
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
	match _stage:
		Globals.SleepStage.AWAKE:
			_bubble_sprite.frame = 3
		Globals.SleepStage.LIGHT:
			_bubble_sprite.frame = 2
		Globals.SleepStage.MEDIUM:
			_bubble_sprite.frame = 1
		Globals.SleepStage.HEAVY:
			_bubble_sprite.frame = 0
		Globals.SleepStage.DEAD:
			_bubble_sprite.frame = 5

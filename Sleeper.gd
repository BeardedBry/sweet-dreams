extends StaticBody2D


export var sleeper: int = 0
onready var sprite: Sprite = $Sprite


func _ready() -> void:
	sprite.frame = sleeper

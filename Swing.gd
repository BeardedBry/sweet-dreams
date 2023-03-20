extends Area2D

onready var bonk_sound = $BonkSound
var despawn_timer = Timer.new()
var has_hit = false


func _ready() -> void:
	despawn_timer.connect("timeout", self, "queue_free")
	despawn_timer.wait_time = 0.5
	despawn_timer.one_shot = true


func _on_Area2D_body_entered(body: CollisionObject2D) -> void:
	if body.has_method("bonk") and not has_hit:
		has_hit = true
		body.bonk()
		bonk_sound.autoplay = true
		bonk_sound.playing = true

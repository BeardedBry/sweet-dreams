extends KinematicBody2D

onready var sprite = $Sprite2
onready var bonk_sound = $BonkSound
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var attack = load("res://Swing.tscn") as PackedScene

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 600

var attack_location = Vector2.ZERO
var velocity = Vector2.ZERO
enum {
	MOVE,
	ATTACK
}

var state = MOVE
var touching: CollisionObject2D = null
var has_hit: bool = false


func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	match state:
		MOVE: 
			move_state(delta)
		ATTACK:
			attack_state(delta)


func move_state(delta):
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Attack/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if sprite.frame in [0, 1, 2, 3]:
		attack_location = Vector2(0, 0)
	elif sprite.frame in [10, 11, 12]:
		attack_location = Vector2(0, -21)
	elif sprite.frame in [4, 5, 6]:
		attack_location = Vector2(10, -11)
	elif sprite.frame in [7, 8, 9]:
		attack_location = Vector2(-10, -11)

	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		var attack_inst = attack.instance()
		attack_inst.global_position = position + attack_location
		get_parent().add_child(attack_inst)


func attack_state(_delta: float) -> void:
	velocity = Vector2.ZERO
	animation_state.travel("Attack")


func attack_animation_finished() -> void:
	state = MOVE

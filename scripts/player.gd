extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@onready var label := $Label
@onready var sprite := $AnimatedSprite2D #108x135
@onready var colShape := $CollisionShape2D
func _ready():
	_recenter_label()
	label.resized.connect(_recenter_label)               # width changes

func _process(delta: float) -> void:
	label.position.x = label.size.x * -0.5
	label.text = "(" + str(roundf(position.x)) + ", " + str(roundf(position.y)) + ")"
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		sprite.play()
	else:
		sprite.stop()

func _recenter_label():
	print("recentered")
	label.position.x = -label.size.x * 0.5

extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@onready var label := $Label
@onready var sprite := $AnimatedSprite2D #108x135
@onready var colShape := $CollisionShape2D

func _ready():
	screen_size = get_viewport_rect().size
	_recenter_label()
	label.resized.connect(_recenter_label)      
	hide()     # width changes

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.x != 0:
		sprite.animation = "walk"
		sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		sprite.animation = "up"
		sprite.flip_v = velocity.y > 0
	else:
		sprite.flip_v = false
	
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

		sprite.play()
	else:
		sprite.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	label.position.x = label.size.x * -0.5
	label.text = "(" + str(roundf(position.x)) + ", " + str(roundf(position.y)) + ")"

func _recenter_label():
	label.position.x = -label.size.x * 0.5

func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	colShape.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	colShape.disabled = false

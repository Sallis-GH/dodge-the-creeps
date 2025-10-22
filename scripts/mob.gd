extends RigidBody2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	var mob_types = Array(sprite.sprite_frames.get_animation_names())
	sprite.animation = mob_types.pick_random()
	sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

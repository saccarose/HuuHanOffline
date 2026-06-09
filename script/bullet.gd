extends Area2D

const speed = 320
const BULLET_RANGE = 20000

var travelled_distance = 0

func _ready() -> void:
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	global_rotation_degrees = fmod(global_rotation_degrees, 360.0)
	
	print(global_rotation_degrees)

	if global_rotation_degrees < 90 or global_rotation_degrees > -90:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
		
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	travelled_distance += delta * speed
	if travelled_distance > BULLET_RANGE:
		queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()

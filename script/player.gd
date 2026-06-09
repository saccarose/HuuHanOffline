extends CharacterBody2D

const PLAYER_SPEED = 128

const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)

var movement = Vector2()

func _ready():
	visible = true
	
func _physics_process(_delta):
	movement = Vector2()
				
	if Input.is_action_pressed("pee"):
		movement = Vector2()
		$AnimatedSprite2D.play("peeing")
	elif Input.is_action_pressed("poop"):
		movement = Vector2()
		$AnimatedSprite2D.play("shiting")
		
	else:
		if Input.is_action_pressed("ui_right"):
			movement += RIGHT
		if Input.is_action_pressed("ui_left"):
			movement += LEFT
		if Input.is_action_pressed("ui_up"):
			movement += UP
		if Input.is_action_pressed("ui_down"):
			movement += DOWN

		if movement != Vector2.ZERO:
			if movement.x > 0:
				$AnimatedSprite2D.flip_h = false
			elif movement.x < 0:
				$AnimatedSprite2D.flip_h = true
				
			if $AnimatedSprite2D.animation != "running" :
				$AnimatedSprite2D.play("running")
		else:
			if $AnimatedSprite2D.animation != "idle":
				$AnimatedSprite2D.play("idle")
	
	movement = movement.normalized()
	movement *= PLAYER_SPEED
	set_velocity(movement)
	move_and_slide()

func _process(delta: float) -> void:
	pass

func shoot():
	var bullet = preload("res://scene/bullet.tscn")
	var new_bullet = bullet.instantiate()
	new_bullet.position = $Marker.position
	$Marker.add_child(new_bullet)


func _on_shoot_timer_timeout() -> void:
	if Input.is_action_pressed("shoot"):
		shoot()

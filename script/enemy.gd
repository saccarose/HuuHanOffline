extends CharacterBody2D

const SPEED = 32
var direction

const MAX_HEALTH = 3
@onready var player = get_node("../Player")

var health

func _ready() -> void:
	health = MAX_HEALTH

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	direction = Vector2(player.global_position - global_position).normalized()
	
	if direction:
		velocity = direction * SPEED

	move_and_slide()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	get_node("../CanvasGroup/PeeBar").value += 5

func take_damage():
	print("auch")
	health -= 1

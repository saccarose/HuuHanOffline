extends Node2D

@export var enemy: PackedScene

func _ready() -> void:
	get_tree().paused = false
	$CanvasGroup/DeathMenu/GameOverMenu.visible = false
	$CanvasGroup/PeeBar.value = 0
	$CanvasGroup/PoopBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $CanvasGroup/PeeBar.value >= 80:
		$CanvasGroup/PeeBar.position.y = 8 + cos(Time.get_ticks_msec() * 0.01)
		$Player/Message.text = "I need to pee. please press E to do that"
		$Player/Message.visible = true
	if $CanvasGroup/PoopBar.value >= 100:
		$CanvasGroup/PoopBar.position.y = 32 + sin(Time.get_ticks_msec() * 0.01)
		$Player/Message.text = "My poop power is on maxximum, please press Q to release that"
		$Player/Message.visible = true
	if $CanvasGroup/PeeBar.value < 80 and $CanvasGroup/PoopBar.value < 100:
		$Player/Message.visible = false
	if $CanvasGroup/PeeBar.value == 100:
		game_over()
	
	if Input.is_action_pressed("pee"):
		$CanvasGroup/PeeBar.value -= 1
	if Input.is_action_pressed("poop"):
		pass
		
func game_over():
	$Player/Message.text = "Uh oh, my bladder is exploded..."
	get_tree().paused = true
	$CanvasGroup/DeathMenu/GameOverMenu.visible = true
		
func _on_timer_timeout() -> void:
	$CanvasGroup/PeeBar.value += 1
	$CanvasGroup/PoopBar.value += 1

func _on_spawn_enemy_timer_timeout() -> void:
	if get_child_count() <= 20:
		spawn_enemy()

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/arena.tscn")

func _on_return_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func spawn_enemy():
	var enemy_x = randi_range(10, 630)
	var enemy_y = randi_range(10, 470)
	var new_enemy = enemy.instantiate()
	new_enemy.global_position = Vector2(enemy_x, enemy_y)
	add_child(new_enemy)

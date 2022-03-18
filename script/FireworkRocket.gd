extends Area2D

const explosion = preload("res://scenes/FireworkExplosion.tscn")

var GRAVITY : float = 350

var velocity : Vector2

var game

func _ready() -> void:
	velocity = Vector2(0, -500 + (randf() * -150))
	
	GRAVITY *= velocity.y / -700
	
	game = get_tree().root.get_node("Game")
	
func _process(delta) -> void:
	position += velocity * delta
	
	velocity.y += GRAVITY * delta
	
	if not $Tween.is_active() and $Timer.is_stopped() and velocity.y >= -300:
		$Timer.start()
	
	if not $Tween.is_active() and velocity.y >= 0:
		modulate.a = 1
		$Sprite.frame = 3
		$Sprite.playing = false
		$Timer.stop()
		$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(0.3, 0, 0, 0), 1.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($Sprite, "rotation_degrees", 0, 180 if randf() < 0.5 else -180, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func _on_Tween_tween_completed(object, key) -> void:
	if key == ":modulate":
		game.lose()
		queue_free()

func _on_Timer_timeout() -> void:
	if modulate.a == 0:
		modulate.a = 1
	else:
		modulate.a = 0

func _on_FireworkRocket_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not $Timer.is_stopped() or $Tween.is_active():
			var boom = explosion.instance()
			boom.position = position
			boom.modulate = Color(randf(), randf(), randf(), 1)
			game.get_node("Fireworks").add_child(boom)
			game.score()
			queue_free()

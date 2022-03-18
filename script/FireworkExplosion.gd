extends Particles2D

func _ready() -> void:
	emitting = true
	$Tween.interpolate_property($Light2D, "texture_scale", 15.0, 0.0, $Timer.wait_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func _process(delta) -> void:
	pass

func _on_Timer_timeout() -> void:
	queue_free()

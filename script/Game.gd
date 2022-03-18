extends Node

const firework = preload("res://scenes/FireworkRocket.tscn") 

var num_spawned: int = 1
var score : int = 0

var lost : bool = false

func _ready() -> void:
	randomize()

func score() -> void:
	if lost:
		return
	
	score += 1
		
	if score == 15 or score == 35 or score == 60:
		num_spawned += 1
		
	$GUILayer/GUI/Score.text = str(score)

func lose() -> void:
	if not lost:
		$Timer.stop()
		lost = true
		
		$GUILayer/GUI/LostDialog/VeritcalContainer/Scores/VBoxContainer/Score.text = str(score)
		
		$GUILayer/GUI/LostDialog.visible = true
		$Tween.interpolate_property($CanvasModulate, "color", Color(0, 0, 0, 1), Color(1, 1, 1, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
func _on_Timer_timeout() -> void:
	for i in range(num_spawned):
		var x = 48 + randf() * (get_viewport().size.x - 96)
		var fw = firework.instance()
		fw.position = Vector2(x, get_viewport().size.y)
		$Fireworks.add_child(fw)
	
	if $Timer.wait_time > 1:
		$Timer.wait_time *= 0.98
		$Timer.stop()
		$Timer.start()

func _on_RetryButton_pressed() -> void:
	score = 0
	lost = false
	num_spawned = 1
	$GUILayer/GUI/LostDialog.hide()
	$GUILayer/GUI/Score.text = "0"
	$Tween.interpolate_property($CanvasModulate, "color", Color(1, 1, 1, 1), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$Timer.start(2.0)

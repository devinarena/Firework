extends Node

const firework = preload("res://scenes/FireworkRocket.tscn") 
const gold_firework = preload("res://scenes/GoldenFireworkRocket.tscn") 

var spawn_count : int = 1
var num_spawned = 0
var score : int = 0

var lost : bool = false

func _ready() -> void:
	randomize()
	$Tween.interpolate_property($ParallaxBackground/ParallaxLayer/CanvasModulate, "color", Color(1, 1, 1, 1), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func _process(delta):
	if not lost:
		$ParallaxBackground.scroll_offset += Vector2(23, 46) * delta
		
func score() -> void:
	if lost:
		return
	
	score += 1
	
	if score >= Globals.high_score:
		Globals.high_score = score
		
	if score == 15 or score == 35 or score == 60:
		spawn_count += 1
		
	$GUILayer/GUI/Score.text = str(score)

func lose() -> void:
	if not lost:
		for fw in $Fireworks.get_children():
			fw.queue_free()
		
		$Timer.stop()
		lost = true
		
		$GUILayer/GUI/LostDialog/VeritcalContainer/Scores/ScoreContainer/Score.text = str(score)
		$GUILayer/GUI/LostDialog/VeritcalContainer/Scores/BestContainer/Score.text = str(Globals.high_score)
		
		$GUILayer/GUI/LostDialog.visible = true
		$Tween.interpolate_property($ParallaxBackground/ParallaxLayer/CanvasModulate, "color", Color(0, 0, 0, 1), Color(1, 1, 1, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
		Globals.save()
		
func _on_Timer_timeout() -> void:
	for i in range(spawn_count):
		num_spawned += 1
		var x = 48 + randf() * (get_viewport().size.x - 96)
		var fw
		if num_spawned % 10 == 0:
			fw = gold_firework.instance()
		else:
			fw = firework.instance()
		fw.position = Vector2(x, get_viewport().size.y)
		$Fireworks.add_child(fw)
	
	if $Timer.wait_time > 1:
		$Timer.wait_time *= 0.98
		$Timer.stop()
		$Timer.start()

func _on_RetryButton_pressed() -> void:
	score = 0
	lost = false
	spawn_count = 1
	$GUILayer/GUI/LostDialog.hide()
	$GUILayer/GUI/Score.text = "0"
	$Tween.interpolate_property($ParallaxBackground/ParallaxLayer/CanvasModulate, "color", Color(1, 1, 1, 1), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$Timer.start(2.0)

func _on_HomeButton_pressed():
	get_tree().change_scene_to(load("res://scenes/Menu.tscn"))

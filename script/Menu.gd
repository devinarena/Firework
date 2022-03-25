extends Control

const game = preload("res://scenes/Game.tscn")

func _ready() -> void:
	pass

func _on_PlayButton_pressed():
	get_tree().change_scene_to(game)

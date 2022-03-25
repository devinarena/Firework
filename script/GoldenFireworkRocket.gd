extends "res://script/FireworkRocket.gd"

func explode() -> void:
	var boom = explosion.instance()
	boom.position = position
	boom.modulate = Color(1, 1, 0, 1)
	game.get_node("Fireworks").add_child(boom)
	game.score()
	queue_free()
	var coins : int = round(1 + (randf() * 99))
	Globals.coins += coins
	Globals.gold_fireworks += 1
	print("%s coins" % coins)

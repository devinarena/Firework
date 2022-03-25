extends Node

const save_file : String = "user://user_data.save"
var high_score : int = 0
var total_fireworks : int = 0
var gold_fireworks : int = 0
var played : int = 0
var color : Color = Color(0, 1, 1, 1)
var coins : int = 0

func _ready() -> void:
	load_save()

func load_save() -> void:
	var f : File = File.new()
	if not f.file_exists(save_file):
		return
	f.open(save_file, File.READ)
	var content : Dictionary = parse_json(f.get_as_text())
	if content.has("high_score"):
		high_score = content["high_score"]
	if content.has("coins"):
		coins = content["coins"]
	if content.has("total_fireworks"):
		total_fireworks = content["total_fireworks"]
	if content.has("gold_fireworks"):
		gold_fireworks = content["gold_fireworks"]
	if content.has("played"):
		played = content["played"]
#	if content.has("color"):
#		color = Color(content["color"]["r"], content["color"]["g"], content["color"]["b"], 1)

func save() -> void:
	var f : File = File.new()
	f.open(save_file, File.WRITE)
	f.store_line(to_json(serialize()))
	f.close()

func serialize() -> Dictionary:
	return {
		"high_score": high_score,
		"total_fireworks": total_fireworks,
		"gold_fireworks": gold_fireworks,
		"played": played,
		"color": {
			"r": color.r,
			"g": color.g,
			"b": color.b,
		},
		"coins": coins,
	}

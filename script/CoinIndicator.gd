extends Panel

func _ready():
	pass # Replace with function body.

func _process(delta) -> void:
	if $Label.text != str(Globals.coins):
		$Label.text = str(Globals.coins)

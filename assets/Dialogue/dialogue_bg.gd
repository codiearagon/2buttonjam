extends ColorRect

export var dialog_path = "res://assets/Dialogue/dialog/dialog.json"
export(float) var text_speed = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$textdelay.wait_time = text_speed
	dialog = getDialog()
	assert(dialog, "Empty dialogue")
	nextPhrase()

func _process(delta):
	$next_indicator.visible = finished
	if Input.is_action_just_pressed("row_right") or Input.is_action_just_pressed("row_left"):
		if finished:
			nextPhrase()
		else:
			$text.visible_characters = len($text.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialog_path), "File does not exist")
	
	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
		
	finished = false
	
	$name.bbcode_text = dialog[phraseNum]["name"]
	$text.bbcode_text = dialog[phraseNum]["text"]
	
	$text.visible_characters = 0;
	while $text.visible_characters < len($text.text):
		$text.visible_characters += 1
		
		$textdelay.start()
		yield($textdelay, "timeout")
		
	finished = true
	$next_indicator/jump.play("jump")
	phraseNum += 1
	return

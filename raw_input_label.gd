extends Label

@export var character: Character


func _ready() -> void:
	character.input_recieved.connect(func(input):
		text = "input_stack: " + str(input)
		)

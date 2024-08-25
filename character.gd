class_name Character
extends CharacterBody2D

# this is just to update RawInputLabel
signal input_recieved(input: Array)

const MOVE_SPEED: int = 300

var input_stack: Array = []
enum move_inputs {
	MOVE_UP,
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT
	}


func _process(delta: float) -> void:
	process_input()
	process_movement()


func process_input() -> void:
	# if a button is pressed we push it to the top of the input stack
	if Input.is_action_just_pressed("move_down"): input_stack.push_front(move_inputs.MOVE_DOWN)
	if Input.is_action_just_pressed("move_up"): input_stack.push_front(move_inputs.MOVE_UP)
	if Input.is_action_just_pressed("move_left"): input_stack.push_front(move_inputs.MOVE_LEFT)
	if Input.is_action_just_pressed("move_right"): input_stack.push_front(move_inputs.MOVE_RIGHT)
	
	# if a button is released we remove it from the input stack regardless of where it is
	if Input.is_action_just_released("move_down"): input_stack.erase(move_inputs.MOVE_DOWN)
	if Input.is_action_just_released("move_up"): input_stack.erase(move_inputs.MOVE_UP)
	if Input.is_action_just_released("move_left"): input_stack.erase(move_inputs.MOVE_LEFT)
	if Input.is_action_just_released("move_right"): input_stack.erase(move_inputs.MOVE_RIGHT)
	
	input_recieved.emit(input_stack)


func process_movement() -> void:
	# to keep track of if we're already processing a direction
	var x_flag: bool = false
	var y_flag: bool = false
	
	# a temporary variable that we always initialize to 0 so the character doesn't retain momentum
	var move_direction: Vector2 = Vector2(0, 0)
	
	for input in input_stack:
		# don't process a direction if we're already heading the other way
		if x_flag and y_flag: break
		if x_flag and (input == move_inputs.MOVE_LEFT or input == move_inputs.MOVE_RIGHT): continue
		if y_flag and (input == move_inputs.MOVE_UP or input == move_inputs.MOVE_DOWN): continue
		
		if input == move_inputs.MOVE_UP:
			move_direction.y = -1
			y_flag = true
		if input == move_inputs.MOVE_DOWN: 
			move_direction.y = 1
			y_flag = true
		if input == move_inputs.MOVE_LEFT: 
			move_direction.x = -1
			x_flag = true
		if input == move_inputs.MOVE_RIGHT: 
			move_direction.x = 1
			x_flag = true
	
	# normalize move_direction so moving on a diagonal retains relative max speed
	# then update our velocity to it
	velocity = move_direction.normalized() * MOVE_SPEED
	
	move_and_slide()

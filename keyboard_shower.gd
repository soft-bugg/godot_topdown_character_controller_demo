extends Node2D

@onready var up: Sprite2D = $Up
@onready var right: Sprite2D = $Right
@onready var left: Sprite2D = $Left
@onready var down: Sprite2D = $Down


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_modulation()
	

func reset_modulation() -> void:
	up.modulate.a = 0.5
	down.modulate.a = 0.5
	left.modulate.a = 0.5
	right.modulate.a = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	reset_modulation()
	if Input.is_action_pressed("move_up"): up.modulate.a = 1
	if Input.is_action_pressed("move_down"): down.modulate.a = 1
	if Input.is_action_pressed("move_left"): left.modulate.a = 1
	if Input.is_action_pressed("move_right"): right.modulate.a = 1

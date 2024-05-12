extends Node


@onready var label = $Label

var health = 100


func _ready():
	label.text = str(health)


func _input(event):
	if !(event is InputEventKey and event.pressed and event.keycode == KEY_SPACE):
		return

	health -= 20
	label.text = str(health)

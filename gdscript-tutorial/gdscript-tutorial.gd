extends Node


@onready var label = $Label


func _ready():
	label.text = "Hello, World!"
	label.modulate = Color.GREEN


func _input(event):
	if !(event is InputEventKey and event.keycode == KEY_SPACE):
		return

	label.modulate = Color.RED if event.pressed else Color.GREEN

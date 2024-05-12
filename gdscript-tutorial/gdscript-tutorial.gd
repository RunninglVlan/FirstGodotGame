extends Node


@onready var label = $Label

var health = 100


func _ready():
	update_label()


func _input(event):
	if !(event is InputEventKey and event.pressed and event.keycode == KEY_SPACE):
		return

	if health <= 0:
		return

	health = max(health - 20, 0)
	update_label()
	$HitSound.play()


func update_label():
	if health > 50:
		label.text = "Healthy"
		label.modulate = Color.GREEN
	elif health > 0:
		label.text = "Injured"
		label.modulate = Color.ORANGE
	else:
		label.text = "Died"
		label.modulate = Color.RED

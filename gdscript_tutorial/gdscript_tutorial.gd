extends Node


const CENTER = Vector2(1152 / 2, 648 / 2)
const HIT_MAX_X_OFFSET = 200
const HIT_MAX_Y_OFFSET = 75

@onready var label = $Label

var health := 100:
	set(value):
		health = max(value, 0)

var healthy := HealthState.new("Healthy", Color.GREEN)
var injured := HealthState.new("Injured", Color.ORANGE)
var died := HealthState.new("Died", Color.RED)

var hit = load("res://gdscript_tutorial/hit.tscn")


func _ready():
	update_label()


func _input(event):
	if !(event is InputEventKey and event.pressed and event.keycode == KEY_SPACE):
		return

	if health <= 0:
		return

	var hit_amount = randi_range(10, 20)
	add_hit(hit_amount)
	health -= hit_amount
	update_label()
	$HitSound.play()


func update_label():
	if health > 50:
		label.text = healthy.text
		label.modulate = healthy.color
	elif health > 0:
		label.text = injured.text
		label.modulate = injured.color
	else:
		label.text = died.text
		label.modulate = died.color


func add_hit(amount):
	var hit_instance = hit.instantiate()
	hit_instance.get_node("Amount").text = str(-amount)
	var position = CENTER
	position.x += randi_range(-HIT_MAX_X_OFFSET, HIT_MAX_X_OFFSET)
	position.y += randi_range(-HIT_MAX_Y_OFFSET, HIT_MAX_Y_OFFSET)
	hit_instance.position = position
	add_child(hit_instance)


class HealthState:
	var text: String
	var color: Color

	func _init(_text: String, _color: Color):
		text = _text
		color = _color

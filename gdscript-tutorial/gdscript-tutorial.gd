extends Node


const CENTER = Vector2(1152 / 2, 648 / 2)
const HIT_MAX_X_OFFSET = 200
const HIT_MAX_Y_OFFSET = 75

@onready var label = $Label

var health := 100
var hit = load("res://gdscript-tutorial/hit.tscn")


func _ready():
	update_label()


func _input(event):
	if !(event is InputEventKey and event.pressed and event.keycode == KEY_SPACE):
		return

	if health <= 0:
		return

	var hit_amount = randi_range(10, 20)
	add_hit(hit_amount)
	health = max(health - hit_amount, 0)
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


func add_hit(amount):
	var hit_instance = hit.instantiate()
	hit_instance.get_node("Amount").text = str(-amount)
	var position = CENTER
	position.x += randi_range(-HIT_MAX_X_OFFSET, HIT_MAX_X_OFFSET)
	position.y += randi_range(-HIT_MAX_Y_OFFSET, HIT_MAX_Y_OFFSET)
	hit_instance.position = position
	add_child(hit_instance)

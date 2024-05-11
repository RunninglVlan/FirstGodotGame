extends Node2D


const SPEED = 60

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

var direction = -1


func _process(delta):
	if (ray_cast_right.is_colliding()):
		change_direction(-1)
	elif (ray_cast_left.is_colliding()):
		change_direction(1)

	position.x += direction * SPEED * delta

func change_direction(value):
	direction = value
	animated_sprite.flip_h = false if value == 1 else true

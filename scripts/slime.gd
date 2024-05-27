extends Node2D


const SPEED = 60

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

var direction = -1


func _ready():
	multiplayer.peer_connected.connect(stop_process)


func stop_process(_id: int):
	if not multiplayer.is_server():
		set_process(false)


func _process(delta):
	if (ray_cast_right.is_colliding()):
		change_direction.rpc(-1)
	elif (ray_cast_left.is_colliding()):
		change_direction.rpc(1)

	position.x += direction * SPEED * delta


@rpc("call_local")
func change_direction(value):
	direction = value
	animated_sprite.flip_h = false if value == 1 else true

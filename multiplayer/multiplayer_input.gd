extends MultiplayerSynchronizer


signal jumped

var direction = 0


func _ready():
	if not is_multiplayer_authority():
		set_physics_process(false)
		set_process(false)


func _physics_process(_delta):
	direction = Input.get_axis("move_left", "move_right")


func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		jump.rpc()


@rpc("call_local")
func jump():
	if multiplayer.is_server():
		jumped.emit()

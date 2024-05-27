extends MultiplayerSynchronizer


var direction = 0


func _ready():
	if not is_multiplayer_authority():
		set_physics_process(false)


func _physics_process(_delta):
	direction = Input.get_axis("move_left", "move_right")

extends AnimatableBody2D


@export var animation_player: AnimationPlayer


func _ready():
	if animation_player:
		multiplayer.peer_connected.connect(stop_animation_player)


func stop_animation_player(_id: int):
	if not multiplayer.is_server():
		animation_player.stop()
		animation_player.set_active(false)

extends Area2D


@onready var timer = $Timer
@onready var hurt_sound = $HurtSound


func _on_body_entered(body):
	if not MultiplayerManager.multiplayer_enabled:
		singleplayer_dead(body)
	else:
		multiplayer_dead(body)


func singleplayer_dead(body):
	hurt_sound.play()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func multiplayer_dead(body):
	if not multiplayer.is_server():
		return
	body.mark_dead()
	play_hurt_sound.rpc()


@rpc("call_local")
func play_hurt_sound():
	hurt_sound.play()

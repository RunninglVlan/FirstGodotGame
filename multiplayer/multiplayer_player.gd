extends CharacterBody2D


const SPEED = 130
const JUMP_VELOCITY = -300

@export var player_id := 1:
	set(id):
		player_id = id
		$InputSynchronizer.set_multiplayer_authority(id)

@onready var input_synchronizer = $InputSynchronizer
@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var camera = $Camera2D
@onready var collision_shape = $CollisionShape2D
@onready var respawn_timer = $RespawnTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var on_floor = false


func _ready():
	input_synchronizer.jumped.connect(on_jumped)
	if multiplayer.get_unique_id() == player_id:
		camera.make_current()
	else:
		camera.enabled = false


func _physics_process(delta):
	if multiplayer.is_server():
		handle_movement(delta)
		on_floor = is_on_floor()

	handle_animation()


func on_jumped():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_jump_sound.rpc()


func handle_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = input_synchronizer.direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func handle_animation():
	if (direction != 0):
		animated_sprite.flip_h = false if direction > 0 else true
	if on_floor:
		animated_sprite.play("idle" if direction == 0 else "run")
	else:
		animated_sprite.play("jump")


@rpc("call_local")
func play_jump_sound():
	jump_sound.play()


func mark_dead():
	Engine.time_scale = 0.5
	collision_shape.set_deferred("disabled", true)
	respawn_timer.start()


func _on_respawn_timer_timeout():
	Engine.time_scale = 1
	position = Vector2(0, 0)
	velocity = Vector2.ZERO

	# Workaround for https://github.com/godotengine/godot/issues/45131
	await get_tree().physics_frame
	await get_tree().physics_frame

	collision_shape.set_deferred("disabled", false)

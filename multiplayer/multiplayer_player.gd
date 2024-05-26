extends CharacterBody2D


const SPEED = 130
const JUMP_VELOCITY = -300

@export var player_id := 1:
	set(id):
		player_id = id

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	handle_animation(direction)

	move_and_slide()


func handle_animation(direction):
	if (direction != 0):
		animated_sprite.flip_h = false if direction > 0 else true
	if is_on_floor():
		animated_sprite.play("idle" if direction == 0 else "run")
	else:
		animated_sprite.play("jump")

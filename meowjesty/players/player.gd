extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		$AnimatedSprite2D.animation = "running"


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jumping"
		
	# Continously moving
	velocity.x = SPEED

	move_and_slide()

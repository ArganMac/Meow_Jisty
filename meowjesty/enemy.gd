extends CharacterBody2D


const SPEED = -500.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	# Continuously moving
	velocity.x = SPEED

	move_and_slide()




func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.animation = "hurt"

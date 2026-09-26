extends CharacterBody2D
class_name Player

const SPEED = 800.0
const JUMP_VELOCITY = -600.0

var last_animation = "running"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 1.2 * get_gravity() * delta
	elif ($AnimatedSprite2D.animation == "jumping" || last_animation == "jumping"):
		last_animation = $AnimatedSprite2D.animation
		$AnimatedSprite2D.play("running")
		
	if Input.is_action_just_pressed("hit_z") or Input.is_action_just_pressed("hit_x"):
		if $AnimatedSprite2D.animation != "attack":
			last_animation = $AnimatedSprite2D.animation
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("attack")
	

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if $AnimatedSprite2D.animation != "jumping":
			last_animation = $AnimatedSprite2D.animation
		$AnimatedSprite2D.play("jumping")
		
		
	# Continously moving
	velocity.x = SPEED

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_on_floor():
		$AnimatedSprite2D.play("running")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body == $"../enemy"):
		body.animation = "hurt"
		pass
	pass

extends CharacterBody2D
class_name Enemy


var SPEED = -500.0
const JUMP_VELOCITY = -400.0
var YSPEED = -200.0
var is_dead = false
var in_player = false
var health = 100


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and not is_dead:
		velocity += get_gravity() * delta
	elif is_dead:
		velocity.y = YSPEED

	# Continuously moving
	velocity.x = SPEED
	
		
	if is_dead:
		$"AnimatedSprite2D".animation = "hurt"
		SPEED = -300
		
	move_and_slide()
	
	
func take_damage() -> void:
	is_dead = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	
	if body is Player:
		in_player = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	in_player = false
	
func set_dead(isDead: bool) -> void:
	is_dead = isDead
